module FileTransferComponent
  module Commands
    class Rename
      include Command

      initializer :name

      def self.build(file_id:, name:, reply_stream_name: nil)
        instance = new(file_id, name)
        instance.reply_stream_name = reply_stream_name
        instance.configure
        instance
      end

      def self.call(file_id:, name:, reply_stream_name: nil)
        instance = build(file_id:, name:, reply_stream_name: reply_stream_name)
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
        Messages::Commands::Rename.build(
          file_id: file_id,
          name: name,
          time: clock.iso8601
        )
      end
    end
  end
end
