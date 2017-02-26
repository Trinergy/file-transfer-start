module FileTransferComponent
  module Handlers
    class Events
      # class Initiated
        include Messaging::Handle
        include Messaging::Postgres::StreamName # includes the stream_name method
        include FileTransferComponent::Messages::Commands
        include FileTransferComponent::Messages::Events
        include Log::Dependency

        dependency :write, Messaging::Postgres::Write
        dependency :clock, Clock::UTC
        dependency :store, FileTransferComponent::Store
        dependency :cloud_store, CloudStore

        def configure
          Messaging::Postgres::Write.configure self
          Clock::UTC.configure self
          FileTransferComponent::Store.configure self
          CloudStore.configure self
        end

        category :file_transfer

        handle Initiated do |initiated|
            # initiated = {
            #   file_id: String
            #   name: String
            #   temp_path: String
            #   time: String
            #   processed_time: String
            # }

            file_id = initiated.file_id

            file, stream_version =  store.get(file_id, include: :version)

            time = clock.iso8601

            ok, file_cloud_uri = cloud_store.upload(initiated.temp_path)

            stream_name = stream_name(file_id)

            published_event = Messages::Events::Published.new()

            published_event.file_id = initiated.file_id
            published_event.file_cloud_uri =file_cloud_uri[:address]

            if ok
              file_transfer_published = Published.follow(published_event)

              file_transfer_published.processed_time = time

              write.(file_transfer_published, stream_name, expected_version: stream_version)
            else
              # need to decide what to do here! good question to monday
            end
        end
      # end
    end
  end
end
