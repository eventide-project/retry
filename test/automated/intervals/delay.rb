require_relative '../automated_init'

context "Intervals" do
  context "Delay" do
    elapsed = Retry::Controls::Time::Elapsed.measure do
      begin
        Retry.(millisecond_intervals: [100]) { fail }
      rescue
      end
    end

    tolerance = 100..110

    test "Delays for the duration of the interval" do
      assert(tolerance.include? elapsed)
    end
  end
end
