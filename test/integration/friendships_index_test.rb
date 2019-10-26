require 'test_helper'

class FriendshipsIndexTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:james)
    @other_user = users(:dale)
    @user_3 = users(:gordon)
    @user_4 = users(:phillip)
    @friendship_one = Friendship.create(user: @user,  friend: @other_user  )
    
  end


  test "must be logged in to view friends" do 
  	get friendships_path 
    assert_redirected_to new_user_session_path
    log_in_as(@user)
    get friendships_path
    assert_template 'friendships/index'
    assert_not @user.friends.empty?
    first_page_of_friends = @user.friends.page(1).per(15)

    first_page_of_friends.each do |friend|
    assert_select 'a[href=?]', user_path(friend), text: friend.name 
    
    
  end

  end	

end
