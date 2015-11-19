# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'redis_counter_cache/version'

Gem::Specification.new do |spec|
  spec.name          = "redis_counter_cache"
  spec.version       = RedisCounterCache::VERSION
  spec.authors       = ["misoobu"]
  spec.email         = ["misoobu@me.com"]

  spec.summary       = "Counter cache function by Redis"
  spec.homepage      = "https://github.com/misoobu/redis_counter_cache"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport"
  spec.add_dependency "activerecord"
  spec.add_dependency "redis-objects"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "mock_redis"
  spec.add_development_dependency "mysql2"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
