require_relative '../automated_init'

context "Retry" do
  context "Specific Error" do
    context "Single Error" do
      context "Not raised" do
        success = Retry.(ErrorA) { }

        test "Indicates success" do
          assert(success)
        end
      end

      context "Specific Error Raised" do
        success = Retry.(ErrorA) { raise ErrorA }

        test "Indicates failure" do
          refute(success)
        end
      end

      context "Other Error Raised" do
        test "Error is re-raised" do
          assert proc { Retry.(ErrorA) { raise RuntimeError } } do
            raises_error? RuntimeError
          end
        end
      end
    end
  end
end
