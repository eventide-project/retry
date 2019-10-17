require_relative '../automated_init'

context "Telemetry" do
  context "Intervals Depleted" do
    rtry = Retry.new

    millisecond_intervals = [11]
    errors = [Retry::Controls::ErrorA, Retry::Controls::ErrorB]

    sink = Retry.register_telemetry_sink(rtry)

    test "Last error is raised" do
      assert_raises(Retry::Controls::ErrorB) do
        rtry.(errors, millisecond_intervals: millisecond_intervals) do |i|
          raise errors[i] if i == 0 # First attempt
          raise errors[i] if i == 1 # Second attempt (first retry, gets raised)
        end
      end
    end

    test "2 cycles" do
      assert(sink.records.length == 2)
    end

    context "Cycles" do
      context "Failed" do
        2.times do |i|
          telemetry_data = sink.records[i].data

          test "cycle [#{telemetry_data.cycle}]" do
            assert(telemetry_data.cycle == i)
          end

          test "error [#{telemetry_data.error}]" do
            assert(telemetry_data.error == errors[i])
          end

          test "millisecond_interval [#{telemetry_data.millisecond_interval}]" do
            assert(telemetry_data.millisecond_interval == millisecond_intervals[i])
          end
        end
      end
    end
  end
end
