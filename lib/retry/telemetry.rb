class Retry
  module Telemetry
    class Sink
      include ::Telemetry::Sink

      record :failed
      record :succeeded
    end

    module Data
      Failed = Struct.new :cycle, :error, :millisecond_interval do
        def error_class
          error.class
        end
      end

      Succeeded = Struct.new :cycle
    end

    def self.sink
      Sink.new
    end

    module Register
      def register_telemetry_sink(rtry)
        sink = Retry::Telemetry.sink
        rtry.telemetry.register(sink)
        sink
      end
    end
  end
end
