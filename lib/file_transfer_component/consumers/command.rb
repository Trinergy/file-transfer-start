module FileTransferComponent
  module Consumers
    class Command
      include Consumer::Postgres

      handler Handlers::Commands::Initiate
      handler Handlers::Commands::Rename

      # Errors are handled by this method. If omitted, the default action when an
      # error is raised during the dispatching of a message is to re-raise the error
      def error_raised(error, event_data)
        #SomeErrorNotificationService.(error)
        #WriteNotProcessable.(event_data)
      end
    end
  end
end
