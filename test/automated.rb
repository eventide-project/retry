ENV['TEST_BENCH_EXCLUDE_FILE_PATTERN'] ||= '/_|sketch|(_init\.rb|_tests\.rb)\z'

require_relative './test_init'

TestBench::CLI.()
