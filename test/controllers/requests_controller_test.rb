require 'test_helper'

class RequestsControllerTest < ActionDispatch::IntegrationTest

	  def setup
			@user = users(:james)
    	@other_user = users(:dale)
    	@user_three = users(:gordon)
    	@request = Request.new(user: @other_user, pending_friend: @user)
  	end
 
  	test "must be logged in to create request" do 

  		assert_no_difference 'Request.count' do
  			post requests_path, params: { pending_friend: @other_user.id } 
  		end

  		log_in_as(@user)
  		get requests_path

  		assert_difference 'Request.count', +1 do
	  		post requests_path, params: { pending_friend: @other_user.id } 
	  	end	
      assert_select 'div.alert', "Request sent"
	  	assert_redirected_to users_path
	  	follow_redirect!
	  	
  	end	

  	test "can't create request when already friends" do 
  		log_in_as(@user)
  		@user.friends<<@other_user

  		assert_no_difference 'Request.count' do
  			post requests_path, params: { pending_friend: @other_user.id } 
  		end
  		assert_redirected_to users_path
  		follow_redirect!
  		assert_select 'div.alert', "Unable to send request"
  	end	

  	test "can't create request when request outstanding between users" do 
  		log_in_as(@user)
  		@request = Request.new(user: @other_user, pending_friend: @user)
  		@request.save
  		
  		assert_no_difference 'Request.count' do
  			post requests_path, params: { pending_friend: @other_user.id } 
  		end
  		assert_redirected_to users_path
  		follow_redirect!
  		assert_select 'div.alert', "Unable to send request"
  	end	


  	test "must be logged in to destroy request" do 
  		@request = Request.new(user: @other_user, pending_friend: @user)
  		@request.save

  		assert_no_difference 'Request.count' do 
  			delete request_path @request
  		end	
  	end	



  	test "successful destroy request by user and pending_friend" do
  		log_in_as(@user)
  		@request = Request.new(user: @other_user, pending_friend: @user)
  		@request.save
  		assert_difference 'Request.count', -1 do 
  			delete request_path @request
  		end	

  		@request_new = Request.new(user: @user, pending_friend: @other_user)
  		@request_new.save
  		assert_difference 'Request.count', -1 do 
  			delete request_path @request_new
  		end	
  	end	


  	 test "must be logged in to accept request" do 

  		@request = Request.new(user: @other_user, pending_friend: @user)
  		@request.save
  		assert_no_difference 'Friendship.count' do 
   				put request_path @request
   		end
   		assert_redirected_to new_user_session_path


  	end



  	test "accept request and create friendship" do 
  		log_in_as(@user)
  		@request = Request.new(user: @other_user, pending_friend: @user)
  		@request.save
  		assert_difference 'Friendship.count', +2 do 
   				put request_path @request
   		end
   		assert_redirected_to requests_path
   		follow_redirect!
   		assert_select 'div.alert', "Friendship created"

  	end	


  	test "accept request and create friendship deletes request" do 
  		log_in_as(@user)
  		@request = Request.new(user: @other_user, pending_friend: @user)
  		@request.save
  		assert_difference 'Request.count', -1 do 
  				put request_path @request
  		end	
  	end	
 
end
