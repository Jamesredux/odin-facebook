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
                                      current_password: "password" } }
    assert_not flash.empty?    
    @user.reload
    assert_not_equal name, @user.name
    assert_redirected_to new_user_session_path
  end 	



end
