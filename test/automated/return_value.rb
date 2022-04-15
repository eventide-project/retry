require_relative 'automated_init'

context "Return Value" do
  control_return_value = SecureRandom.hex

  return_value = Retry.() do
    control_return_value
  end

  test do
    assert(return_value == control_return_value)
  end
end
