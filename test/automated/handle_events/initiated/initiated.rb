require_relative '../../automated_init'

context 'handle command' do
  # Command before just for study reasons
    # handler1 = Handlers::Commands.new
    #
    # clock_time = Controls::Time::Raw.example
    # time = Controls::Time::ISO8601.example(clock_time)
    #
    # handler1.clock.now = clock_time
    #
    # initiate = Controls::Commands::Initiate.example
    #
    # handler1.(initiate)

  # command end

  handler = Handlers::Events.new

  handler.write = handler1.write
  cloud_store = FileTransferComponent::Controls::CloudStore.example

	clock_time = Controls::Time::Raw.example
	time = Controls::Time::ISO8601.example(clock_time)

	handler.clock.now = clock_time
  handler.cloud_store = cloud_store

  initiated = Controls::Events::Initiated.example

	handler.(initiated)

	context 'Initiate' do
		writes = handler.write.writes do |written_event|
			written_event.class.message_type == 'Published'
		end
		published = writes.first.data.message

		test 'published event is written' do
			refute(published.nil?)
		end

		context 'Recorded stream attributes' do
			test 'File id set' do
				assert(published.file_id == initiated.file_id)
			end

			test 'File cloud_uri set' do
        refute(published.file_cloud_uri.nil?)
			end
		end
	end
end
