class Retry

  def initialize
  end

  def self.build(*errors, millisecond_intervals: nil)

  end

  def self.call(*errors, millisecond_intervals: nil, &action)
    millisecond_intervals ||= [0]
    millisecond_intervals = millisecond_intervals.to_enum

    retries = 0

    error = nil
    probe = proc { |e| error = e }

    loop do
      success = Try.(*errors, error_probe: probe) do
        action.call(retries)
      end

      break if success

      retries += 1

      interval = millisecond_intervals.next
      break if interval.nil?

      sleep (interval/1000.0)
    end

    unless error.nil?
      raise error
    end

    return retries
  end
end
