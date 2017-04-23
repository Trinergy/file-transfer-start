module FileTransferComponent
  module Controls
    class CloudStoreFail
      def self.build
        new
      end

      def upload(file)
        [false, {error: "invalid file type"}]
      end
      def self.example
        file = CloudStoreFail.build
        file
      end
    end
  end
end
