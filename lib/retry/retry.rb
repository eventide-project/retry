class Retry
  include Log::Dependency
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

    logger.trace { "Starting retry (Errors: #{errors.empty? ? '(none)' : errors.join(', ')}, Millisecond Intervals: #{millisecond_intervals.join(', ')})" }

    intervals = millisecond_intervals.to_enum

    cycle = 0

    error = nil
    probe = proc { |e| error = e }
    result = nil

    loop do
      success = Try.(errors, error_probe: probe) do
        logger.debug { "Attempting (Cycle: #{cycle})" }
        result = action.call(cycle)
      end

      action_executed&.call(cycle)

      if success
        logger.info { "Attempt succeeded (Cycle: #{cycle})" }
        telemetry.record :succeeded, Retry::Telemetry::Data::Succeeded.new(cycle)
        break
      end

      interval = nil
      Try.(StopIteration) do
        interval = intervals.next
      end

      logger.debug { "Attempt failed (Cycle: #{cycle}, Error: #{error.class.name})" }
      telemetry.record :failed, Retry::Telemetry::Data::Failed.new(cycle, error, interval)

      if interval.nil?
        logger.debug { 'No more attempts. Intervals depleted.' }
        break
      end

      logger.debug { "Will retry. Sleeping #{interval} milliseconds before next attempt." }
      sleep (interval/1000.0)

      cycle += 1
    end

    unless error.nil?
      logger.info { "Attempts failed. Will not retry. Raising error: #{error.class.name}. (Cycle: #{cycle})" }
      raise error
    end

    result
  end
end
