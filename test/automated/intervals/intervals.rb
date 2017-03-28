require_relative '../automated_init'

context "Intervals" do
  count = 0

  begin
    Retry.(millisecond_intervals: [0, 0]) do |i|
      count += 1
      fail
    end
  rescue
  end

  test "One retry per interval" do
    assert(count == 3)
  end
end
