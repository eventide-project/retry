class Retry
  module Controls
    module Dependency
      def self.example
        Example.new
      end

      class Example
        ::Dependency.activate(self)

        dependency :rtry, Retry
      end
    end
  end
end
