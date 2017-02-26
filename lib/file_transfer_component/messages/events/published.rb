module FileTransferComponent
  module Messages
    module Events
      class Published
        include Messaging::Message

        attribute :file_id, String
        attribute :file_cloud_uri, String
        attribute :processed_time, String
      end
    end
  end
end
