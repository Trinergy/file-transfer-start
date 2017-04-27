module FileTransferComponent
  module Messages
    module Events
      class CopiedToDisk
        include Messaging::Message

        attribute :file_id, String
        attribute :file_path, String
        attribute :processed_time, String

      end
    end
  end
end
