require_relative '../automated_init'

context "Substitute" do
  context "Dependency" do
    receiver = Retry::Controls::Dependency.example

    test "Is a specialized implementation" do
      assert(receiver.rtry.instance_of?(Retry::Substitute::Retry))
    end
  end
end
