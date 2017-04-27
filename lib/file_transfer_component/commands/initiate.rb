module FileTransferComponent
  module Commands
    class Initiate
      include Command
      attr_writer :file_id, :temp_path

      initializer :name, :temp_path

      def self.build(name, temp_path, reply_stream_name: nil)
        instance = new(name, temp_path)
        instance.reply_stream_name = reply_stream_name
        instance.configure
        instance
      end

      def self.call(name, temp_path, reply_stream_name: nil)
        instance = build(name, temp_path, reply_stream_name: reply_stream_name)
        instance.()
      end

      def file_id
        @file_id ||= identifier.get
      end

      def call
        write_command
        file_id
      end

      def command
        Messages::Commands::Initiate.build(
          file_id: file_id,
          name: name,
          temp_path: temp_path,
          time: clock.iso8601
        )
      end
    end
  end
end
