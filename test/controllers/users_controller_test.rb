require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
	
  test "should get new" do
    get new_user_registration_path
    assert_response :success
  end

  def setup
  	@user = users(:james)
  	@other_user = users(:dale)
  end

  test "should redirect edit when not signed in" do
  	get edit_user_registration_path
  	assert_not flash.empty?
  	assert_redirected_to new_user_session_path
  end	

  test "should redirect update when not signed in" do 
  	name = "Kevin"
  	put user_registration_path params: { user: { name: name, email: @user.email, 
                                      password: '', password_confirmation: '',
                                      current_password: "password"  } }
    assert_not flash.empty?    
    @user.reload
    assert_not_equal name, @user.name
    assert_redirected_to new_user_session_path
  end 	

  test "should redirect users index when not logged in" do
    get users_path
    assert_redirected_to new_user_session_path
  end  

  test "should not allow the admin attribute to be updated via the web" do
    log_in_as(@other_user)
    assert_not @other_user.admin?
    put user_registration_path params: { user: { name: @other_user.name, email: @other_user.email, 
                                      password: '', password_confirmation: '',
                                      current_password: "password",
                                      admin: true } }
    assert_not @other_user.reload.admin?                                   
  end  

  test "should redirect destroy when not logged in" do 
    assert_no_difference 'User.count' do
      delete user_path(@user) 
    end  
    assert_redirected_to new_user_session_path
  end  

  test "should redirect destroy when logged in as non-admin" do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do 
      delete user_path(@user)
    end
    assert_redirected_to root_url   

  end  
end
