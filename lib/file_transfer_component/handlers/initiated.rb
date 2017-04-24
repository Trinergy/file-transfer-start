module FileTransferComponent
  module Handlers
    class Events
      class Initiated
        include Messaging::Handle
        include Messaging::Postgres::StreamName
        include FileTransferComponent::Messages::Commands
        include FileTransferComponent::Messages::Events
        include Log::Dependency

        dependency :write, Messaging::Postgres::Write
        dependency :store, FileTransferComponent::Store
        dependency :clock, Clock::UTC
        dependency :cloud_store, CloudStore #local_storage at the moment

        def configure
          Messaging::Postgres::Write.configure self
          FileTransferComponent::Store.configure self
          CloudStore.configure self
          Clock::UTC.configure self
          # Settings.instance.set self
        end

        category :file_transfer


        handle Messages::Events::Initiated do |initiated|
          logger.trace { "Copying file" }
          logger.trace(tag: :verbose) { initiated.pretty_inspect }


          file_id = initiated.file_id

          file, stream_version = store.get(file_id, include: :version)

          if file.stored_permanently?
            logger.debug "#{initiated} command was ignored. File transfer #{file_id} was transfered to permanent storage on #{file.permanent_storage_time}."
            return
          end

          key = "#{file.id}-#{initiated.name}"

          ok, meta = cloud_store.upload(initiated.temp_path)
          time = clock.iso8601
          stream_name = stream_name(file_id)

          if ok
            copied_to_disk = CopiedToDisk.follow(initiated, include: [:file_id])

            copied_to_disk.file_path = meta[:address]

            copied_to_disk.processed_time = time

            write.(copied_to_disk, stream_name, expected_version: stream_version)

            logger.info { "File copied" }
            logger.info(tag: :verbose) { copied_to_disk.pretty_inspect }
          else
            copy_failed = CopyFailed.follow(initiated, include: [:file_id])

            copy_failed.error_message = meta[:error]

            copy_failed.processed_time = time

            write.(copy_failed, stream_name, expected_version: stream_version)

            logger.info { "File copy failed" }
            logger.info(tag: :verbose) { copy_failed.pretty_inspect }
          end
        end
      end
    end
  end
end
