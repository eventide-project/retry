class Retry
  module Substitute
    def self.build
      Retry.new()
    end

    class Retry #< ::Retry
      ## telemetry
      ## retries: count
    end
  end
end
