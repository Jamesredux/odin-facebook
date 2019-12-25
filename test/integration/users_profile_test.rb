require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
  	@user = users(:james)
  end

  test "profile display" do 
  	log_in_as(@user)
  	get user_path(@user)
  	assert_template 'users/show'
  	assert_select 'title', full_title(@user.name)
  	assert_select 'a', text: @user.name
  	assert_select 'nav.pagination'

  	#only check first 10 as other drop onto next page because
  	#of first 4 dummy posts in fixtures
  	@user.posts.page(1).per(10) do |post|
      assert_match post.content, response.body
    end  
 	
  end	

end
