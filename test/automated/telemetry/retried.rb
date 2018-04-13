require_relative '../automated_init'

context "Telemetry" do
  context "Retried" do
    rtry = Retry.new([])

    millisecond_intervals = [1, 11]
    errors = [Retry::Controls::ErrorA, Retry::Controls::ErrorB]

    rtry.millisecond_intervals = millisecond_intervals.to_enum

    sink = Retry.register_telemetry_sink(rtry)

    rtry.() do |i|
      raise errors[i] if i == 0
      raise errors[i] if i == 1
    end

    test "2 retries" do
      assert(sink.records.length == 2)
    end

    telemetry_data = sink.retried_records.first.data

    millisecond_intervals.each_with_index do |millisecond_interval, i|
      telemetry_data = sink.retried_records[i].data

      context "retries" do
        test "retry [#{telemetry_data.retry}]" do
          assert(telemetry_data.retry == i + 1)
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
