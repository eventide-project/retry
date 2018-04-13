require_relative '../automated_init'

context "Configure" do
  context "Receiver Attribute" do
    context "Default" do
      receiver = Retry::Controls::Receiver.example

      instance = Retry.configure(receiver)

      test "rtry attribute is assigned the Retry instance" do
        assert(receiver.rtry == instance)
      end
    end

    context "Specific Attribute" do
      receiver = Retry::Controls::Receiver.example

      instance = Retry.configure(receiver, attr_name: :other_retry)

      test "other_retry attribute is assigned the Retry instance" do
        assert(receiver.other_retry == instance)
      end
    end
  end
end
