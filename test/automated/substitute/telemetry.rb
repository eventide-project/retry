require_relative '../automated_init'

context "Substitute" do
  context "Telemetry" do
    context "Sink" do
      rtry = Retry::Substitute.build

      test "Is configured" do
        assert(rtry.sink.instance_of?(Retry::Telemetry::Sink))
      end
    end
  end
end
