module FileTransferComponent
  class File
    include Schema::DataStructure

    attribute :id, String
    attribute :name, String
    attribute :path, String
    attribute :initiated_time, Time
    attribute :permanent_storage_time, Time
    attribute :last_updated_time, Time

    def stored_permanently?
      !permanent_storage_time.nil?
    end
  end
end
