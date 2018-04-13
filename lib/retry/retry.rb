class Retry
  include ::Telemetry::Dependency
  extend Retry::Telemetry::Register

  def action_executed(&action)
    unless action.nil?
      self.action_executed = action
    end

    @action_executed
  end
  attr_writer :action_executed

  def self.build
    new
  end

  def self.configure(receiver, attr_name: nil)
    attr_name ||= :rtry
    instance = build
    receiver.public_send("#{attr_name}=", instance)
    instance
  end

  def self.call(*errors, millisecond_intervals: nil, &action)
    instance = build
    instance.(errors, millisecond_intervals: millisecond_intervals, &action)
  end

  def call(*errors, millisecond_intervals: nil, &action)
    errors = errors.flatten
    millisecond_intervals ||= [0]

    intervals = millisecond_intervals.to_enum

    retries = 0

    error = nil
    probe = proc { |e| error = e }

    loop do
      success = Try.(errors, error_probe: probe) do
        action.call(retries)
      end

      action_executed&.call(retries)

      break if success

      retries += 1

      interval = intervals.next

      telemetry.record :retried, Retry::Telemetry::Data.new(retries, error.class, interval)

      break if interval.nil?

      sleep (interval/1000.0)
    end

    unless error.nil?
      raise error
    end

    retries
  end
end
