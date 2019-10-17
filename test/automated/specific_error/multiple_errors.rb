require_relative '../automated_init'

context "Specific Error" do
  context "Multiple Errors" do
    context "Not raised" do
      retries = Retry.(ErrorA, ErrorB) { }

      test "Action is not retried" do
        assert(retries == 0)
      end
    end

    [ErrorA, ErrorB].each do |error_class|
      context "Specific Error Raised (#{error_class.name.split('::').last})" do
        retries = Retry.(ErrorA, ErrorB) do |i|
          raise error_class if i == 0
        end

        test "Action is retried" do
          assert(retries == 1)
        end
      end
    end

    context "Other Error Raised" do
      test "Error is re-raised" do
        assert_raises(RuntimeError) do
          Retry.(ErrorA, ErrorB) do |i|
            raise RuntimeError if i == 0
          end
        end
      end

      test "Action is not retried" do
        count = 0

        begin
          Retry.(ErrorA, ErrorB) do |i|
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
