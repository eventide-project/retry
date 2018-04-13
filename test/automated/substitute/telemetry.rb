require_relative '../automated_init'

context "Substitute" do
  context "Telemetry" do
    context "Sink" do
      rtry = Retry::Substitute.build

      millisecond_intervals = [1, 11]
      errors = [Retry::Controls::ErrorA, Retry::Controls::ErrorB]

      test "Is configured" do
        assert(rtry.sink.instance_of?(Retry::Telemetry::Sink))
      end
    end
  end
end
