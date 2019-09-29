require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
 
 test "invalid signup information" do 
 	get new_user_registration_path
 	assert_no_difference 'User.count' do 
 		post users_path, params: { user: { name: "",
 																				email: "foo@invalid",
 																				password: "foo",
 																				password_confirmation: "bar" } }
 	end																			

 	assert_template 'devise/registrations/new'
 	assert_select 'div#error_explanation'
  assert_select 'div.alert'
 end	

 test "valid signup information" do 
 	get new_user_registration_path
 	assert_difference 'User.count', 1 do 
 		post users_path, params: { user: { name: "test user",
 																				email: "testuser@example.com",
 																				password: "foobar",
 																			 password_confirmation: "foobar" } }
 	end																		 
 		follow_redirect!
 		assert_template 'static_pages/home'
 		assert_not flash.empty?
 		assert_select "a[href=?]", destroy_user_session_path
 end	

end
