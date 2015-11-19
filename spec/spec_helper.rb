$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'redis_counter_cache'
require "mock_redis"

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.before(:suite) do
    Redis.current = MockRedis.new
  end

  config.around do |example|
    ActiveRecord::Base.transaction do
      example.run

      raise ActiveRecord::Rollback
    end
  end
end

Dir[File.join(File.dirname(__FILE__), "./support/**/*.rb")].each { |f| require f }
