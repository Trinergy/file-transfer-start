require_relative '../../automated_init'

context "Handle Commands" do
  context "Accept command" do
    fixture = Fixtures::Handler.build(
      handler: Handlers::Commands::Rename.new,
      input_message: Controls::Commands::Rename.example,
      record_new_entity: false
    )

    fixture.(output: "Renamed") do |test|

      test.assert_accepted

      test.assert_attributes_copied([
        :file_id,
        :name,
        :temp_path,
        :time
      ])
    end
  end
end
