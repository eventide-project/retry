require_relative 'init'
require 'test_bench'; TestBench.activate

context "Retries" do

end


# - - -

context "Returns true when nothing is raised" do
  success = Try.() { puts "Doesn't raise" }
  assert(success)
end

context "Returns false when an error raised" do
  success = Try.() { raise RuntimeError }
  refute(success)
end

# Specific error class

context "Returns true when nothing is raised" do
  success = Try.(RuntimeError) { }
  assert(success)
end

context "Returns true when the error is raised" do
  success = Try.(RuntimeError) { raise RuntimeError }
  refute(success)
end

class SomeError < RuntimeError; end

context "Re-raises when the specified error is not raised" do
  assert proc { Try.(SomeError) { raise RuntimeError } } do
    raises_error? RuntimeError
  end
end

# Multiple error classes are specified

context "Returns true when nothing is raised" do
  success = Try.(RuntimeError, SomeError) { }
  assert(success)
end

context "Returns true when one of the errors is raised" do
  success = Try.(RuntimeError, SomeError) { raise RuntimeError }
  refute(success)
end

class SomeOtherError < SomeError; end

context "Re-raises when one of the specified errors is not raised" do
  assert proc { Try.(SomeError, SomeOtherError) { raise RuntimeError } } do
    raises_error? RuntimeError
  end
end
