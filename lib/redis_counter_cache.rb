require "redis_counter_cache/version"
require "active_support"
require "active_support/core_ext"
require "active_record"
require "redis-objects"

module RedisCounterCache
  extend ActiveSupport::Concern

  module ClassMethods
    def redis_counter_cache(association_name, scope: nil, expiration: 1.week, after_cache: nil)
      counter_method_name = _counter_method_name(association_name, scope)
      recount_method_name = "update_#{counter_method_name}_cache"
      redis_counter_name = "#{counter_method_name}_cache"

      value redis_counter_name, expiration: expiration

      define_method(counter_method_name) do
        redis_counter = __send__(redis_counter_name)

        if redis_counter.value
          redis_counter.value.to_i
        else
          __send__(recount_method_name, redis_counter)
        end
      end

      define_method(recount_method_name) do |redis_counter = __send__(redis_counter_name)|
        relation = __send__(association_name)

        if scope
          Array(scope).each do |scope|
            relation = relation.__send__(scope)
          end
        end

        redis_counter.value = count = relation.count

        after_cache.call(self) if after_cache

        count
      end
    end

    private
    def _counter_method_name(association_name, scope)
      scope_name =
        if scope
          Array(scope).join("_") + "_"
        else
          ""
        end

      "#{scope_name}#{association_name}_count"
    end
  end
end
