describe RedisCounterCache, "(use User and UserItem as an example)" do
  it "has a version number" do
    expect(RedisCounterCache::VERSION).not_to be nil
  end

  describe User do
    before do
      @user = User.create(id: 1)
      UserItem.create(user_id: 1, active: true)
      UserItem.create(user_id: 1, active: true)
      UserItem.create(user_id: 1, active: false)
      UserItem.create(user_id: 2, active: true)
      UserItem.create(user_id: 2, active: false)
    end

    describe "#user_items_count" do
      before { @user.update_user_items_count_cache }
      it "equal user_items.count" do
        expect(@user.user_items_count).to eq @user.user_items.count
      end
    end

    describe "#active_user_items_count" do
      before { @user.update_active_user_items_count_cache }
      it "equal user_items.active.count" do
        expect(@user.active_user_items_count).to eq @user.user_items.active.count
      end
    end

    describe "#update_user_items_count_cache" do
      before do
        @return_value = @user.update_user_items_count_cache
        @user_items_count = @user.user_items.count
      end

      it "update cache" do
        expect(@user.user_items_count_cache.value.to_i).to eq @user_items_count
      end

      it "return user_items.count" do
        expect(@return_value).to eq @user_items_count
      end
    end

    describe "#update_user_items_count_cache(counter)" do
      before do
        @return_value = @user.update_user_items_count_cache(@user.user_items_count_cache)
        @user_items_count = @user.user_items.count
      end

      it "update cache" do
        expect(@user.user_items_count_cache.value.to_i).to eq @user_items_count
      end

      it "return user_items.count" do
        expect(@return_value).to eq @user_items_count
      end
    end
  end
end
