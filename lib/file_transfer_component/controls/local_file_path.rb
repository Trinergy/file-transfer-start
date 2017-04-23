module FileTransferComponent
  module Controls
    module LocalFilePath
      def self.example
        ::File.absolute_path('tmp/buffer/file_01.ext')
      end
    end
  end
end
