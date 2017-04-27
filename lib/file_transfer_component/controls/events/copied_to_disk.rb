module FileTransferComponent
  module Controls
    module Events
      module CopiedToDisk
        def self.example
          copied_to_disk = FileTransferComponent::Messages::Events::CopiedToDisk.build

          copied_to_disk.file_id = ID.example
          copied_to_disk.file_path = 'some/file/path'
          copied_to_disk.processed_time = Controls::Time::Processed.example

          copied_to_disk
        end
      end
    end
  end
end
