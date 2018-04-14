class Retry
  module Telemetry
    class Sink
      include ::Telemetry::Sink

      record :tried
    end

    Data = Struct.new :cycle, :error, :millisecond_interval

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
