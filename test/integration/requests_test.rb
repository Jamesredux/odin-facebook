require 'test_helper'

class RequestsTest < ActionDispatch::IntegrationTest

	  def setup
			@user = users(:james)
    	@other_user = users(:dale)
    #	@user_three = users(:gordon)
    #	@request = Request.new(user: @other_user, pending_friend: @user)
      log_in_as(@user)
  	end


    test "should create request the standard way" do 
      assert_difference 'Request.count', 1 do 
        post requests_path, params: { pending_friend: @other_user.id }
      end  
    end

    test "should create request through Ajax" do 
      assert_difference 'Request.count', 1 do 
        post requests_path, xhr: true,   params: { pending_friend: @other_user.id }
      end 
    end

    test "should cancel request standard way" do 
      @request = Request.new(user: @user, pending_friend: @other_user)
      @request.save
      
      assert_difference 'Request.count', -1 do 
        delete request_path @request
      end 
    end  

    test "should cancel request with Ajax" do 
      @request = Request.new(user: @user, pending_friend: @other_user)
      @request.save

      assert_difference 'Request.count', -1 do
          delete request_path @request, xhr: true
      end  

    end  

end
