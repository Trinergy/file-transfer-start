module FileTransferComponent
  module Controls
    class CloudStoreSuccess
      def self.build
        new
      end

      def upload(file)
        destination = ::File.absolute_path("../files_dir/#{::File.basename(file) }")
        FileUtils.cp file, destination
        return [true, {address: destination}]
      end
      def self.example
        file = CloudStoreSuccess.build
        file
      end
    end
  end
end
