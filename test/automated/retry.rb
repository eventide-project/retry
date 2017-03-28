require_relative 'automated_init'

context "Retry" do
  context "Error not raised" do
    count = 0

    Retry.() { count += 1 }

    test "Action is executed once" do
      assert(count == 1)
    end
  end

  context "Error Raised" do
    context "Error Does Not Recur" do
      count = 0

      Retry.() do |i|
        count += 1
        fail if i == 0
      end

      test "Action is retried" do
        assert(count == 2)
      end
    end

    context "Error Recurs" do
      test "Error is raised" do
        assert proc { Retry.() { fail } } do
          raises_error? RuntimeError
        end
      end
    end
  end
end
