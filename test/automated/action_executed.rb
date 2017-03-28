require_relative 'automated_init'

context "Action Executed" do
  count = 0

  rtry = Retry.build()

  rtry.action_executed do
    count += 1
  end

  rtry.() do |i|
    fail if i == 0
  end

  test "Block is executed once for each execution of the action" do
    assert(count == 2)
  end
end
