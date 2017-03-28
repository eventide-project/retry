module Retry
  def self.call(*errors, intervals: nil, &action)
    intervals ||= [0]
    intervals = intervals.to_enum

    retries = 0

    error = nil
    probe = proc { |e| error = e }

    loop do
      success = Try.(*errors, error_probe: probe) do
        action.call(retries)
      end

      break if success

      retries += 1

      interval = intervals.next
      break if interval.nil?

      sleep interval
    end

    unless error.nil?
      raise error
    end

    return retries
  end
end
