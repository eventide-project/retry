require_relative '../automated_init'

context "Specific Error" do
  context "Single Error" do
    context "Not raised" do
      retries = Retry.(ErrorA) { }

      test "Action is not retried" do
        assert(retries == 0)
      end
    end

    context "Specific Error Raised" do
      retries = Retry.(ErrorA) do |i|
        raise ErrorA if i == 0
      end

      test "Action is retried" do
        assert(retries == 1)
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
        count = 0

        begin
          Retry.(ErrorA) do |i|
            count += 1
            raise RuntimeError if i == 0
          end
        rescue
        end

        assert(count == 1)
      end
    end
  end
end
