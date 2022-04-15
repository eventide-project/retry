require_relative '../automated_init'

context "Error Raised" do
  context "Error Does Not Recur" do
    context do
      cycles = 0

      Retry.() do |i|
        cycles += 1
        fail if i == 0
      end

      test "Retried once (action was executed twice)" do
        assert(cycles == 2)
      end
    end
  end

  context "Error Recurs" do
    test "Error is raised" do
      assert_raises(RuntimeError) do
        Retry.() { fail }
      end
    end
  end
end
