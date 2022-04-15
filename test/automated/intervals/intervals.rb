require_relative '../automated_init'

context "Intervals" do
  cycles = 0

  begin
    Retry.(millisecond_intervals: [0, 0]) do |i|
      cycles += 1
      fail
    end
  rescue
  end

  test "One retry per interval" do
    assert(cycles == 3)
  end
end
