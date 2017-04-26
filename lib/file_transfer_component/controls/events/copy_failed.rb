module FileTransferComponent
  module Controls
    module Events
      module CopyFailed
        def self.example
          copy_failed = FileTransferComponent::Messages::Events::CopyFailed.build

          copy_failed.file_id = ID.example
          copy_failed.processed_time = Controls::Time::Processed.example

          copy_failed
        end
      end
    end
  end
end
