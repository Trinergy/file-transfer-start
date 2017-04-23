#TODO rename to FileTransferComponent
require 'pp'

require 'eventide/postgres'
require 'consumer/postgres'

require 'file_transfer_component/messages/commands/initiate'

require 'file_transfer_component/messages/events/initiated'

require 'file_transfer_component/file'
require 'file_transfer_component/projection'
require 'file_transfer_component/store'

require 'file_transfer_component/handlers/commands'
require 'file_transfer_component/handlers/events'

require 'file_transfer_component/handlers/initiated'
require 'file_transfer_component/commands/command'
require 'file_transfer_component/commands/initiate'

require 'file_transfer_component/consumers/command'
require 'file_transfer_component/consumers/events'
