require_relative '../automated_init'

context "Error not raised" do
  context do
    cycles = 0

    Retry.() do
      cycles += 1
    end

    test "Action is executed once" do
      assert(cycles == 1)
    end
  end
end
