module FileTransferComponent
  module Handlers
    class Events
      class Initiated
        include Messaging::Handle
        include Messaging::Postgres::StreamName
        include FileTransferComponent::Messages::Commands
        include FileTransferComponent::Messages::Events
        include Log::Dependency

        setting :region
        setting :bucket

        dependency :write, Messaging::Postgres::Write
        dependency :store, FileTransferComponent::Store
        dependency :clock, Clock::UTC
        dependency :cloud_store, CloudStore # ::S3

        def configure
          Messaging::Postgres::Write.configure self
          FileTransferComponent::Store.configure self
          CloudStore.configure self
          Clock::UTC.configure self
        end

        category :file_transfer


        handle Messages::Events::Initiated do |initiated|
          logger.trace { "Copying file" }
          logger.trace(tag: :verbose) { initiated.pretty_inspect }


          file_id = initiated.file_id

          file, stream_version = store.get(file_id, include: :version)

          # unless file.cloud_uri.nil?
          #   logger.debug "#{initiated} event was ignored. File transfer #{file_id} has already been published"
          # end

          key = "#{file.id}-#{initiated.name}"

          cloud_store.upload(initiated.uri, region, bucket, key)


          time = clock.iso8601

          copied = CopiedToS3.follow(initiated, include: [:file_id])
          copied.processed_time = time

          copied.key = key
          copied.bucket = bucket
          copied.region = region

          stream_name = stream_name(file_id)
          write.(copied, stream_name, expected_version: stream_version)

          logger.info { "File copied" }
          logger.info(tag: :verbose) { copied.pretty_inspect }
        end
      end
    end
  end
end
