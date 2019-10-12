require 'test_helper'

class RequestsIndexTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:james)
    @other_user = users(:dale)
    @user_three = users(:gordon)
    @request = Request.create(user: @other_user, pending_friend: @user)
  end

  test "must be logged in to view requests" do 
    get requests_path
    assert_redirected_to new_user_session_path
    log_in_as(@user)
    get requests_path
    assert_template 'requests/index'

  	
  end	

  test "must to logged in to accept and decline requests" do

    assert_no_difference 'Request.count' do 
       delete request_path @request
    end   


    assert_no_difference 'Request.count' do 
       put request_path, params: { request: { id:  @request   } }
    end 

  end 


end
