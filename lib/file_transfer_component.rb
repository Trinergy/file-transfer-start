#TODO rename to FileTransferComponent

require 'cloud_store'

require 'pp'

require 'eventide/postgres'


require 'file_transfer_component/messages/commands/initiate'

require 'file_transfer_component/messages/events/initiated'
require 'file_transfer_component/messages/events/copied_to_disk'
require 'file_transfer_component/messages/events/copy_failed'

require 'file_transfer_component/file'


require 'file_transfer_component/projection'
require 'file_transfer_component/store'
require 'file_transfer_component/handlers/commands'
require 'file_transfer_component/handlers/initiated'
