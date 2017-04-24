module FileTransferComponent
  class Projection
    include EntityProjection
    include Messages::Events

    entity_name :file

    apply Initiated do |initiated|
        SetAttributes.(file, initiated, copy: [
            {file_id: :id},
            :name,
        ])

        file.initiated_time = Time.parse(initiated.processed_time)
    end

    apply CopiedToDisk do |initiated|
        SetAttributes.(file, initiated, copy: [
            :file_id,
            {file_path: :path},
            :name,
        ])

        file.permanent_storage_time = Time.parse(initiated.processed_time)
    end

    # apply CopyFailed do |copy_failed|
    #     file.not_found_time = Time.parse(not_found.processed_time)
    # end
  end
end
