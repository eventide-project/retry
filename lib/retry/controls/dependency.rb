class Retry
  module Controls
    module Dependency
      def self.example
        Example.new
      end

      class Example
        include Dependency

        dependency :rtry, Retry
      end
    end
  end
end
