require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  
  def setup
  	@admin = users(:james)
    @non_admin  = users(:dale)  	
  end

  test "index including pagination" do 
  	log_in_as(@admin)
  	get users_path
  	assert_template 'users/index'
  	assert_select 'nav.pagination'
    first_page_of_users = User.page(1).per(15)
    first_page_of_users.each do |user|
    	assert_select 'a[href=?]', user_path(user), text: user.name
      #this is not working now, it does not seem that admin is on first page??
      unless user == @admin
       assert_select 'a[href=?]', user_path(user), text: 'delete'
      end  
   	end
    assert_difference 'User.count', -1 do 
      delete user_path(@non_admin)
    end  
  end	

  test "index as non-admin" do
    log_in_as(@non_admin)
    get users_path
    assert_select 'a', text: 'delete', count: 0
  end

end
