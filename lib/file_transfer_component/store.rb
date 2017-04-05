module FileTransferComponent
	class Store
		include EntityStore
    # Read model?
		category 'file_transfer'
		entity File
		projection Projection
		reader EventSource::Postgres::Read
	end
end
