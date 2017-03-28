module Retry
  def self.call(*errors, &action)
    success = false

    begin
      action.call
      success = true
    rescue Exception => e
      unless errors.empty?
        unless errors.include? e.class
          raise e
        end
      end
    end

    success
  end
end
