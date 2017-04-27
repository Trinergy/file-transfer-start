module FileTransferComponent
  module Messages
    module Events
      class CopyFailed
        include Messaging::Message

        attribute :file_id, String
        attribute :error_message, String
        attribute :processed_time, String
      end
    end
  end
end
