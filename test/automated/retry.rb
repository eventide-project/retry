require_relative 'automated_init'

context "Retry" do
  context "Error not raised" do
    success = Retry.() { }

    test "Indicates success" do
      assert(success)
    end
  end

  context "Error raised" do
    success = Retry.() { fail }

    test "Indicates failure" do
      refute(success)
    end
  end
end
