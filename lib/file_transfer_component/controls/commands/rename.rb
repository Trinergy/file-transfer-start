module FileTransferComponent
  module Controls
    module Commands
      module Rename
        def self.example

          initiate = FileTransferComponent::Messages::Commands::Rename.build

          initiate.file_id = ID.example
          initiate.name = "new_name_for_rename"
          initiate.time = Controls::Time.example

          initiate
        end

        def self.data
          data = example.attributes
          data.delete(:time)
          data
        end
      end
    end
  end
end
