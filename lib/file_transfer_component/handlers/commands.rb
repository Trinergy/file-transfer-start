module FileTransferComponent
  module Handlers
    class Commands
      include Messaging::Handle
      include Messaging::Postgres::StreamName # includes the stream_name method
      include FileTransferComponent::Messages::Commands
      include FileTransferComponent::Messages::Events
      include Log::Dependency

      dependency :write, Messaging::Postgres::Write
      dependency :clock, Clock::UTC
      dependency :store, FileTransferComponent::Store

      def configure
        Messaging::Postgres::Write.configure self
        Clock::UTC.configure self
        FileTransferComponent::Store.configure self
      end

      category :file_transfer

      handle Initiate do |initiate|
        # initiate = {
        #   timestamp: today
        #   file_id: 1
        #   file_tmp_path: /tmp/aushduashdasd
        # }

        # get file id from cmd payload
        file_id = initiate.file_id

        # projects the file in its current state(all events played on entity) with its version(help dealing with concurrency)
        file, stream_version =  store.get(file_id, include: :version)

        unless file.nil?
          logger.debug "#{initiate} command was ignored. File trasfer #{file_id} was already initiated"
          return
        end

        time = clock.iso8601

        # returns intiated struc, 'follow' lets you know ehrtr the call was made from(kind o stack trace)
        file_transfer_initiated = Initiated.follow(initiate)
        # update the time stamp to current time, because "initate.timestamp"
        # might not reflect current time, could be in queue for x amount of time
        file_transfer_initiated.processed_time = time

        # file_transfer:id from the category in line 18
        stream_name = stream_name(file_id)

        # writing to category file_transfer stream, the iniated event
        write.(file_transfer_initiated, stream_name, expected_version: stream_version)
      end
    end
  end
end
