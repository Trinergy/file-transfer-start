module FileTransferComponent
  module Messages
    module Events
      class Renamed
        include Messaging::Message

        attribute :file_id, String
        attribute :name, String
        attribute :time, String
        attribute :processed_time, String
      end
    end
  end
end
