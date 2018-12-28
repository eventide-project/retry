# retry

Retry an execution that terminates with an error

## Overview

The `Retry` library provides basic retry functionality with a clear and simple API. It supports:

- Retrying on any error
- Retrying on a specific error
- Retrying based on a list of possible errors
- Retrying once or many times
- Backoff intervals that allow delaying between retries

## Examples

### Retry on Any Error

Any error will cause the block to retry. The block will only retry once.

``` ruby
tries = 0

Retry.() do
  tries += 1

  # RuntimeError will be raised during the first iteration
  # The block will be executed once again without raising an error
  # for a total of 2 executions
  if tries == 1
    raise RuntimeError
  end
end

puts tries
# => 2
```

### Retry on a Specific Error

The block will be retried only if the specified error is raised in the block.

``` ruby
SomeError = Class.new(RuntimeError)

tries = 0

Retry.(SomeError) do
  tries += 1

  puts tries

  # SomeError will be raised during the first iteration
  # and the block will be executed once again
  if tries == 1
    raise SomeError
  end

  # Will raise RuntimeError in the second iteration
  # RuntimeError is not retried, and so the program
  # terminates with here RuntimeError
  raise RuntimeError
end

# => 1
# => 2
# => RuntimeError
```

### Retry on Multiple Specific Errors

The block will be retried if any of the the specified errors are raised in the block.

``` ruby
SomeError = Class.new(RuntimeError)
SomeOtherError = Class.new(RuntimeError)

tries = 0

Retry.(SomeError, SomeOtherError) do
  tries += 1

  puts tries

  # SomeOtherError will be raised during the first iteration
  # and the block will be executed once again
  if tries == 1
    raise SomeOtherError
  end

  # Will raise RuntimeError in the second iteration
  # RuntimeError is not retried, and so the program
  # terminates here with RuntimeError
  raise RuntimeError
end

# => 1
# => 2
# => RuntimeError
```

### Retry and Back Off

The block will be retried up to the number of delay intervals specified.

The `millisecond_intervals` parameter can be used without specifying a specific error, when specifying a specific error, or when specifying a list of possible errors.

``` ruby
SomeError = Class.new(RuntimeError)
SomeOtherError = Class.new(RuntimeError)

tries = 0

Retry.(SomeError, SomeOtherError, millisecond_intervals: [100, 200]) do
  tries += 1

  puts tries

  raise SomeError
end

# => 1 (first attempt)
# => 2 (second attempt, after 100 ms delay)
# => 3 (third attempt, after 200 ms delay)
# => SomeError
```

## License

The `retry` library is released under the [MIT License](https://github.com/eventide-project/retry/blob/master/MIT-License.txt).
