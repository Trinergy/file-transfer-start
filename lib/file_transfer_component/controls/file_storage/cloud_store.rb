module FileTransferComponent
  module Controls
    class CloudStore
      def self.build
        new
      end

      def upload(file)
        [true, {address: "https://aws_s3/bucket_id/${file.path}"}] #[false, {error: "invalid file type"}]
      end
      def self.example
        file = CloudStore.build
        file
      end
    end
  end
end
