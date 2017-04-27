require_relative '../automated_init'

context "File Projection" do
  fixture = Fixtures::Projection.build(
    projection: Projection,
    entity: Controls::File::Initiated.example,
    event: Controls::Events::CopyFailed.example
  )

  fixture.() do |test|
    test.assert_attributes_copied([
      {file_id: :id},
    ])
    #TODO Assert for stored_pemanently?
  end
end
