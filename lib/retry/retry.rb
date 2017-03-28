class Retry
  initializer :errors

  def millisecond_intervals
    @millisecond_intervals ||= [0].to_enum
  end
  attr_writer :millisecond_intervals

  def self.build(*errors, millisecond_intervals: nil)
    instance = new(errors)
    instance.millisecond_intervals = millisecond_intervals&.to_enum
    instance
  end

  def self.call(*errors, millisecond_intervals: nil, &action)
    instance = build(*errors, millisecond_intervals: millisecond_intervals)
    instance.(&action)
  end

  def call(&action)
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

    retries
  end
end
