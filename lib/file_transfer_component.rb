#TODO rename to FileTransferComponent
require 'pp'

require 'eventide/postgres'


require 'file_transfer_component/messages/commands/initiate'

require 'file_transfer_component/messages/events/initiated'
require 'file_transfer_component/messages/events/copied_to_s3'
require 'file_transfer_component/messages/events/not_found'

require 'file_transfer_component/file'


require 'file_transfer_component/projection'
require 'file_transfer_component/store'
require 'file_transfer_component/handlers/commands'
