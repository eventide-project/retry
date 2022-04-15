require_relative '../automated_init'

context "Intervals" do
  context "Default" do
    context do
      cycles = 0

      begin
        Retry.() do |i|
          cycles += 1
          fail
        end
      rescue
      end

      test "Retried once (action was executed twice)" do
        assert(cycles == 2)
      end
    end

    context do
      elapsed = Retry::Controls::Time::Elapsed.measure do
        begin
          Retry.() { fail }
        rescue
        end
      end

      tolerance_milliseconds = 3

      test "Does not delay" do
        assert(elapsed < tolerance_milliseconds)
      end
    end
  end
end
