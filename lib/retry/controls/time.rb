module Retry
  module Controls
    module Time
      module Elapsed
        def self.measure(&action)
          elapsed = nil
          t1 = ::Time.now

          action.call

          t2 = ::Time.now
          t2 - t1
        end
      end
    end
  end
end
