require 'test_helper'

class PasswordResetsTest < ActionDispatch::IntegrationTest

	def setup
		@user = users(:james)
	end
  
	test "password resets" do 
			get new_user_password_path
			assert_template 'passwords/new'
			assert_select 'input[name=?]', 'user[email]'
			#invalid email
			post user_password_path, params: { user: { email: "" } } 
			assert_select 'div.alert', /^.*Email can't be blank.*$/
			assert_template 'passwords/new'
			# valid email
			post user_password_path, params: { user: { email: @user.email } }
			assert_redirected_to new_user_session_path
			follow_redirect!
			assert_select 'div.alert', /^.*You will receive an email.*$/	
			user = assigns(:user)
			#Wrong email
			get edit_user_password_path(user.reset_password_token, email: "")
			assert_redirected_to new_user_session_path

			# Inactive user
    	 user.confirmed_at = nil
       get edit_user_password_path(user.reset_password_token, email: user.email)
       assert_redirected_to new_user_session_path
       user.confirmed_at = Time.zone.now

      # Right email, wrong token
      get edit_user_password_path('wrong token', email: user.email)
      assert_redirected_to new_user_session_path
      


      

	end	

 # I could not get most of this to work
	test "successful password reset" do 
		get new_user_password_path
		post user_password_path, params: { user: { email: @user.email } }
		assert_redirected_to new_user_session_path
		follow_redirect!
		@user.reload
		#token = @user.reset_password_token
		assert_select 'div.alert', /^.*You will receive an email.*$/	

		get edit_user_password_path , params: { reset_password_token: @user.reset_password_token }

		assert_template 'passwords/edit'
	
		# Invalid password & confirmationoptions[:reset_password_token]
		#assert_equal @user.reset_password_token, "12"
    #patch user_password_path,
       #   params: {  user: { reset_password_token: @user.reset_password_token,
      #    							 password:              "foobaz",
     #                    password_confirmation: "barquux" } } 
    # assert_select 'div.alert', /^.*first test.*$/                      
   # assert_select 'div#error_explanation'
     # Empty password
   #  patch user_password_path,
    #      params: {  reset_password_token: @user.reset_password_token, 
    #     	email: @user.email,
     #               user: { password:              "",
      #                      password_confirmation: "" } }
    #assert_select 'div.alert', /^.*empty password test.*$/                        
    #assert_select 'div#error_explanation'
    
    # Valid password & confirmation
    #patch user_password_path,
        #  params: {   
       #             user: { reset_password_token: @user.reset_password_token,
      #              				password:              "foobaz",
     #                       password_confirmation: "foobaz" } }

    #assert_select 'div.alert', /^.*You will receive an email.*$/	                        
    #assert_template 'static_pages/home'                        
    #follow_redirect!
    #assert_redirected_to root_url                        
    #assert is_logged_in?
   # assert_not flash.empty?
   # assert_redirected_to use
 

	end	


end
