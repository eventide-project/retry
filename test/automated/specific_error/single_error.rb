require_relative '../automated_init'

context "Specific Error" do
  context "Single Error" do
    context "Not raised" do
      cycles = 0
      Retry.(ErrorA) do
        cycles += 1
      end

      test "Action is not retried" do
        assert(cycles == 1)
      end
    end

    context "Specific Error Raised" do
      cycles = 0
      Retry.(ErrorA) do |i|
        cycles += 1
        raise ErrorA if i == 0
      end

      test "Action is retried" do
        assert(cycles == 2)
      end
    end

    context "Other Error Raised" do
      test "Error is re-raised" do
        assert_raises(RuntimeError) do
          Retry.(ErrorA) do |i|
            raise RuntimeError if i == 0
          end
        end
      end

      test "Action is not retried" do
        cycles = 0

        begin
          Retry.(ErrorA) do |i|
            cycles += 1
            raise RuntimeError if i == 0
          end
        rescue
        end

        assert(cycles == 1)
      end
    end
  end
end
