class Retry
  module Substitute
    def self.build
      instance = Retry.new()
      sink = Retry.register_telemetry_sink(instance)
      instance.sink = sink
      instance
    end

    class Retry < ::Retry
      attr_accessor :sink
    end
  end
end
