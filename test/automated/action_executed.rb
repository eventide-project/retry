require_relative 'automated_init'

context "Action Executed" do
  cycles = 0

  rtry = Retry.build()

  rtry.action_executed do
    cycles += 1
  end

  rtry.() do |i|
    fail if i == 0
  end

  test "Block is executed once for each execution of the action" do
    assert(cycles == 2)
  end
end
