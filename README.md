# retry

Retry an execution that terminates with an error

## Examples

### Basics

``` ruby
tries = 0
raise_error = true

Retry.() do
  tries += 1

  if raise_error
    raise_error = false
    fail
  end
end

puts tries
# => 2
```

### Specific Error
``` ruby
tries = 0
raise_error = true

SomeError = Class.new(RuntimeError)

Retry.(SomeError) do
  tries += 1
  puts tries

  if raise_error
    raise_error = false
    raise SomeError
  end

  # Will raise RuntimeError after two tries
  raise RuntimeError
end
```

### Backoff
``` ruby
tries = 0

SomeError = Class.new(RuntimeError)

Retry.(SomeError, millisecond_intervals: [100, 200]) do
  tries += 1
  puts tries

  raise SomeError
end

# => 1
# => 2
# => 3
# => SomeError (SomeError)
```

## License

The `retry` library is released under the [MIT License](https://github.com/retry/blob/master/MIT-License.txt).
