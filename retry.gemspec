# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = 'evt-retry'
  s.version = '1.0.0.2'
  s.summary = 'Retry an execution that terminates with an error, with optional backoff cycles'
  s.description = ' '

  s.authors = ['The Eventide Project']
  s.email = 'opensource@eventide-project.org'
  s.homepage = 'https://github.com/eventide-project/retry'
  s.licenses = ['MIT']

  s.require_paths = ['lib']
  s.files = Dir.glob('{lib}/**/*')
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 2.3.3'

  s.add_runtime_dependency 'evt-try'
  s.add_runtime_dependency 'evt-initializer'
  s.add_runtime_dependency 'evt-dependency'
  s.add_runtime_dependency 'evt-telemetry'
  s.add_runtime_dependency 'evt-log'

  s.add_development_dependency 'test_bench'
end
