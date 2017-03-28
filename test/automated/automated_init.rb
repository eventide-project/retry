require_relative '../test_init'

class ErrorA < RuntimeError; end
class ErrorB < ErrorA; end
