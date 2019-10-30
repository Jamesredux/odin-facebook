require 'test_helper'

class FriendshipTest < ActiveSupport::TestCase
  
  def setup
  	@user = users(:james)
  	@other_user = users(:dale)
  	@friendship = Friendship.new(user: @user, friend: @other_user)
  end

  test "should be valid" do 
  	assert @friendship.valid?
  end	

  test "user should be present" do
  	@friendship.user = nil
  	assert_not @friendship.valid?
  end	

  test "friend should be present" do
  	@friendship.friend = nil
  	assert_not @friendship.valid?
  end	

  test "friend and user can not be the same" do 
  	@friendship.friend = @user
  	assert_not @friendship.valid?
  end
  
  test "can not create duplicate friendship" do 
  	@friendship.save
  	@friendship_new = Friendship.new(user: @user, friend: @other_user)
  	assert_not @friendship_new.valid?
  end		

  test "after create inverse friendship created" do 
  	@friendship.save
  	assert @other_user.friends.include?(@user)
  	#this test fails if after_create is commented out on friendship model
  end	

  test "destroy friendship destroys inverse friendship" do
  	assert_not @user.friends.include?(@other_user)
  	assert_not @other_user.friends.include?(@user)
  	@friendship.save
  	assert @user.friends.include?(@other_user)
  	assert @other_user.friends.include?(@user)
  	@friendship.destroy
  	assert_not @other_user.friends.include?(@user)

  end	


end
