require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

	def setup
    @user = users(:james)
    @other_user = users(:dale)
  end

  test "unsuccessful edit" do 

    post user_session_path params: { user: { email: @user.email, 
                                     password: 'password' } }
                                  
  	get edit_user_registration_path
  	assert_template 'devise/registrations/edit'
  	put user_registration_path params: { user: { name: "", email: "user@invalid", 
                                      password: 'pass', password_confirmation: "word",
                                      current_password: "" } }
    assert_template 'devise/registrations/edit' 
    assert_select 'div.alert', /^.*5 errors prohibited.*$/
  end	

  test "successful edit"  do 
  	post user_session_path params: { user: { email: @user.email, 
                                     password: 'password' } }
                                  
  	get edit_user_registration_path
  	assert_template 'devise/registrations/edit'
  	name = "Jamie"
  	email = "james@example.com"
  	put user_registration_path params: { user: { name: name, email: email, 
                                      password: '', password_confirmation: '',
                                      current_password: "password" } }
    
    assert_redirected_to root_path  
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
  end	

  test "update to already existing email is not allowed" do 
   post user_session_path params: { user: { email: @other_user.email, 
                                      password: 'password' } }
  get edit_user_registration_path 
  put user_registration_path params: { user: { email: @user.email, 
                                              password: 'password' } }
  assert_template 'devise/registrations/edit' 
  assert_select 'div.alert', /^.*Email has already been taken.*$/  
 end 

end
