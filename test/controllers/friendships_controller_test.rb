require 'test_helper'

class FriendshipsControllerTest < ActionDispatch::IntegrationTest
	
	 def setup
  	@user = users(:james)
  	@other_user = users(:dale)
    @user_3 = users(:gordon)
    @user_4 = users(:phillip)
  	@friendship_one = Friendship.create(user: @user,  friend: @other_user  )
  	
  end

  test "should be logged in to view friends" do
    get friendships_path 
    assert_redirected_to new_user_session_path

  end  

   # do I need to test this, am I going to delete create friendship method? It is all handled in requests controller?
  test "should fail to create friendship when not logged in" do 

      assert_no_difference 'Friendship.count' do
      post friendships_path params: { friendship: { user: @user, friend: @other_user } }
      end
      
      assert_redirected_to users_url
   end 


   # do I need to test this, am I going to delete create friendship method?
   test "create friendship if logged in" do 
    log_in_as(@user_3)
    assert_difference 'Friendship.count', +2 do
       post friendships_path params: { friendship: { user: @user_3, friend: @user_4 } }
    end    
    assert_redirected_to root_url

   end 

   test "can not destroy friendship if not logged in " do 
     
    assert_no_difference 'Friendship.count' do 
       delete friendship_path @friendship_one
    end        
   end 

    test "can destroy friendship if logged in" do 
      log_in_as(@user)
      
      assert_difference 'Friendship.count', -2 do
        # delete friendship deletes inverse - so 2 
      delete friendship_path @friendship_one, params: { friendship: { user: @user, friend: @other_user} }
    end 
   end 
 
 end
