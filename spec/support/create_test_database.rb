ActiveRecord::Base.establish_connection(
  YAML.load(File.read("spec/database.yml"))["test"],
)

ActiveRecord::Schema.define version: 0 do
  create_table :users, force: true do |t|
  end

  create_table :user_items, force: true do |t|
    t.integer :user_id
    t.boolean :active
  end
end

class User < ActiveRecord::Base
  include Redis::Objects
  include RedisCounterCache

  has_many :user_items

  redis_counter_cache :user_items
  redis_counter_cache :user_items, scope: :active
end

class UserItem < ActiveRecord::Base
  scope :active, -> { where(active: true) }
end
