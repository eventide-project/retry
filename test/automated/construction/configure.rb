require_relative '../automated_init'

context "Configure" do
  context "Receiver Attribute" do
    context "Default" do
      receiver = Retry::Controls::Receiver.example

      errors = [RuntimeError]
      millisecond_intervals = [1, 11]

      instance = Retry.configure(receiver, RuntimeError, millisecond_intervals: millisecond_intervals)

      test "rtry attribute is assigned the Retry instance" do
        assert(receiver.rtry == instance)
      end

      test "Errors is assigned to the instance" do
        assert(instance.errors == errors)
      end

      test "Intervals is assigned to the instance" do
        assert(instance.millisecond_intervals.to_a == millisecond_intervals)
      end
    end

    context "Specific Attribute" do
      receiver = Retry::Controls::Receiver.example

      errors = [RuntimeError]
      millisecond_intervals = [1, 11]

      instance = Retry.configure(receiver, RuntimeError, attr_name: :other_retry, millisecond_intervals: millisecond_intervals)

      test "other_retry attribute is assigned the Retry instance" do
        assert(receiver.other_retry == instance)
      end

      test "Errors is assigned to the instance" do
        assert(instance.errors == errors)
      end

      test "Intervals is assigned to the instance" do
        assert(instance.millisecond_intervals.to_a == millisecond_intervals)
      end
    end
  end
end
