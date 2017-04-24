module FileTransferComponent
  module Controls
    module Events
      module Initiated
        def self.example

          initiated = FileTransferComponent::Messages::Events::Initiated.build

          initiated.file_id = ID.example
          initiated.name = "some_name"
          initiated.temp_path= "/Users/kennywu/experiments/file-transfer-start/tmp/buffer/file_01.ext"
          initiated.time = Controls::Time::Effective.example
          initiated.processed_time = Controls::Time::Processed.example

          initiated
        end
      end
    end
  end
end
