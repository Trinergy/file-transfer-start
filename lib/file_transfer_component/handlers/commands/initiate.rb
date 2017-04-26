module FileTransferComponent
  module Handlers
    class Commands
      class Initiate
        include Messaging::Handle
        include Messaging::Postgres::StreamName
        include FileTransferComponent::Messages::Commands
        include FileTransferComponent::Messages::Events
        include Log::Dependency

        dependency :write, Messaging::Postgres::Write
        dependency :store, FileTransferComponent::Store
        dependency :clock, Clock::UTC

        def configure
          Messaging::Postgres::Write.configure self
          FileTransferComponent::Store.configure self
          Clock::UTC.configure self
        end

        category :file_transfer


        handle Messages::Commands::Initiate do |initiate|
          logger.trace { "Initiating file transfer" }
          logger.trace(tag: :verbose) { initiate.pretty_inspect }

          file_id = initiate.file_id

          file, stream_version = store.get(file_id, include: :version)

          unless file.nil?
            logger.debug "#{initiate} command was ignored. File transfer #{file_id} was already initiated."
            return
          end

          time = clock.iso8601

          file_transfer_initated = Initiated.follow(initiate)
          file_transfer_initated.processed_time = time

          stream_name = stream_name(file_id)
          write.(file_transfer_initated, stream_name, expected_version: stream_version)

          logger.info { "File transfer initiated" }
          logger.info(tag: :verbose) { file_transfer_initated.pretty_inspect }
        end

        # handle Rename do |rename|
        #   logger.trace { "Initiating file rename" }
        #   logger.trace(tag :verbose) { rename.pretty_inspect }
        #
        #   file_id = rename.file_id
        #
        #   file, stream_version = store.get(file_id, include: :version)
        #
        #   if file.nil?
        #     logger.debug "#{rename} command was ignored. File Transfer #{file_id} does not exist."
        #     return
        #   end
        #
        #   if file.name == rename.name
        #     logger.debug "#{rename} command was ignored. File Transfer #{file_id} has the same name."
        #     return
        #   end
        #
        #   time = clock.iso8601
        #
        #   file_transfer_renamed = Renamed.follow(rename)
        #
        #   file_transfer_renamed.processed_time = time
        #
        #   stream_name = stream_name(file_id)
        #   write.(file_transfer_renamed, stream_name, expected_version: stream_version)
        #
        #   logger.info { "File transfer renamed" }
        #   logger.info(tag: :verbose) { file_transfer_renamed.pretty_inspect }
        # end
      end
    end
  end
end
