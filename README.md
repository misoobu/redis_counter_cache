# RedisCounterCache

Counter cache function by Redis

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'redis_counter_cache'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install redis_counter_cache

## Usage

```ruby
# create_table :users do |t|
# end
class User < ActiveRecord::Base
  include Redis::Objects
  include RedisCounterCache

  has_many :user_items
  redis_counter_cache :user_items
end

# create_table :user_items do |t|
#   t.integer :user_id
# end
class UserItem < ActiveRecord::Base
  belongs_to :user
end

user = User.create
user.user_items.create
user.update_user_items_count_cache # specify updating cache when chenge
user.user_items_count # get count with a cache
# => 1
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

