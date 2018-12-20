# retry

Retry an execution that terminates with an error

## Examples

### Retry on Any Error

``` ruby
tries = 0
raise_error = true

Retry.() do
  tries += 1

  # The raise_error variable is true during the first iteration
  # RuntimeError will be raised during the first iteration
  # The block will be executed once again without raising an error
  if raise_error
    raise_error = false
    raise RuntimeError
  end
end

puts tries
# => 2
```

### Retry on a Specific Error

``` ruby
tries = 0
raise_error = true

SomeError = Class.new(RuntimeError)

Retry.(SomeError) do
  tries += 1
  puts tries

  # The raise_error variable is true during the first iteration
  # SomeError will be raised during the first iteration
  # and the block will be executed once again
  if raise_error
    raise_error = false
    raise SomeError
  end

  # Will raise RuntimeError in the second iteration
  # RuntimeError is not retried, and so the program terminates
  raise RuntimeError
end

# => 1
# => 2
# => RuntimeError
```

### Retry on Multiple Specific Errors

``` ruby
tries = 0
raise_error = true

SomeError = Class.new(RuntimeError)
SomeOtherError = Class.new(RuntimeError)

Retry.(SomeError, SomeOtherError) do
  tries += 1
  puts tries

  # The raise_error variable is true during the first iteration
  # SomeOtherError will be raised during the first iteration
  # and the block will be executed once again
  if raise_error
    raise_error = false
    raise SomeOtherError
  end

  # Will raise RuntimeError in the second iteration
  # RuntimeError is not retried, and so the program terminates
  raise RuntimeError
end

# => 1
# => 2
# => RuntimeError
```

### Retry and Back Off

``` ruby
tries = 0

SomeError = Class.new(RuntimeError)
SomeOtherError = Class.new(RuntimeError)

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
