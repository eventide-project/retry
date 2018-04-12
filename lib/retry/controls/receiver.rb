class Retry
  module Controls
    module Receiver
      def self.example
        Example.new
      end

      class Example
        attr_accessor :rtry
        attr_accessor :other_retry
      end
    end
  end
end
