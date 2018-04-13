class Retry
  module Telemetry
    class Sink
      include ::Telemetry::Sink

      record :retried
    end

    Data = Struct.new :retry, :error, :millisecond_interval

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
