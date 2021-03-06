require 'test_helper'

class UsersSignInTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "sign_in with invalid informatio" do 
  	get new_user_session_path
  	assert_template 'devise/sessions/new'
  	post user_session_path params: { session: { name: "", email: "" } }
  	assert_template 'devise/sessions/new'
  	assert_not flash.empty?
  	assert_select 'div.alert', "Invalid Email or password."
  	get root_path
  	assert flash.empty?
  end	

  def setup
    @user = users(:james)
  end
  
  test "sign in with valid information followed by sign out" do 
    get  new_user_session_path
    log_in_as(@user)

    assert_redirected_to root_path
    follow_redirect!
    assert_template 'static_pages/home'
    assert_select "a[href=?]", new_user_session_path, count: 0  
    assert_select "a[href=?]", destroy_user_session_path
    assert_select "a[href=?]", user_path(@user)
    delete destroy_user_session_path
    assert_redirected_to root_url
    #Simulate user logging out twice  in 2 windows
    delete destroy_user_session_path
    follow_redirect!

    assert_select "a[href=?]", new_user_session_path
    assert_select "a[href=?]", destroy_user_session_path,      count: 0
    assert_select "a[href=?]", user_path(@user), count: 0                              

  end  

  test "sign in with valid email/invalid password" do
    get new_user_session_path
    assert_template 'devise/sessions/new'
    log_in_as(@user, password: 'invalid')

    assert_template 'devise/sessions/new'
    assert_select "a[href=?]", destroy_user_session_path,      count: 0
    assert_not flash.empty?
    get root_path
    assert flash.empty?                                        
  end  
 
end
