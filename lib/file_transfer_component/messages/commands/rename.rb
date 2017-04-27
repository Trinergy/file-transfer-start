module FileTransferComponent
  module Messages
    module Commands
      class Rename
        include Messaging::Message

        attribute :file_id, String
        attribute :name, String
        attribute :time, String
      end
    end
  end
end
