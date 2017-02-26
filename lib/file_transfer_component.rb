# should be a gem
require 'cloud_store'

require 'pp'

require 'eventide/postgres'

require 'file_transfer_component/messages/commands/initiate'

require 'file_transfer_component/messages/events/initiated'
require 'file_transfer_component/messages/events/published'

require 'file_transfer_component/projection'
require 'file_transfer_component/store'

require 'file_transfer_component/handlers/commands'

require 'file_transfer_component/handlers/initiated'
