require_relative '../client_test_init'
require_relative '../test_init'

file_id = ENV['FILE_ID']
name = ENV['NAME']

new_name ||= 'new_name.txt'
local_file_path||= FileTransferComponent::Controls::LocalFilePath.example
name ||= ::File.basename(local_file_path)

file_id = Client::Initiate.(name, local_file_path)



start_time = Time.now
elapsed_time = 0

for i in 0..2
  FileTransferComponent::Consumers::Command.start "fileTransfer:command"
  FileTransferComponent::Consumers::Event.start "fileTransfer"

  sleep(0.5)

  Client::Rename.(file_id: file_id, name: new_name) if i == 0
end
