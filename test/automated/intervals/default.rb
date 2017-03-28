require_relative '../automated_init'

context "Intervals" do
  context "Default" do
    context do
      count = 0

      begin
        Retry.() do |i|
          count += 1
          fail
        end
      rescue
      end

      test "Retried once (action was executed twice)" do
        assert(count == 2)
      end
    end

    context do
      elapsed = Retry::Controls::Time::Elapsed.measure do
        begin
          Retry.() { fail }
        rescue
        end
      end

      tolerance = 0.001

      test "Does not delay" do
        assert(elapsed < tolerance)
      end
    end
  end
end
