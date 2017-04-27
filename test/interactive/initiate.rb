require_relative '../client_test_init'
require_relative '../test_init'

name = ENV['NAME']
uri = ENV['URI']

name ||= 'test.md'
local_file_path||= FileTransferComponent::Controls::LocalFilePath.example

file_id = Client::Initiate.(name, uri)

puts file_id
