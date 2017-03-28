require_relative '../automated_init'

context "Intervals" do
  context do
    count = 0

    Retry.() { count += 1 }

    test "Action is executed once" do
      assert(count == 1)
    end
  end

  context "Count of Retries" do
    retries = Retry.() { }

    test "0" do
      assert(retries == 0)
    end
  end
end
