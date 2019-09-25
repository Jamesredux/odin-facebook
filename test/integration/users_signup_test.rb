require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
 
 test "invalid signup information" do 
 	get new_user_registration_path
 	assert_no_difference 'User.count' do 
 		post users_path, params: { user: { name: "",
 																				email: "foo@invalid",
 																				password: "foo",
 																				password_confirmation: "bar"} }
 	end																			

 	assert_template 'devise/registrations/new'
 	assert_select 'div#error_explanation'
  assert_select 'div.alert'
 end	
end
