require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
  	@user = User.new(name: "Example User", email: "user@example.com", password: "foobar")	
  end	


   test "should be valid" do
     assert @user.valid?
   end

   test "name should be present" do
   	@user.name = "     "
   	assert_not @user.valid?
   end	

   test "email should be present" do 
   		@user.email = "    "
   		assert_not @user.valid?
   end
   
   test "name should not be too long" do 
   	@user.name = "a" * 60
   	assert_not @user.valid? 	
   end	

   test "email should not be too long" do 
   	@user.email = "a" * 244 + "@example.com"
   	assert_not @user.valid?
   end
   
   test "password should not be too long" do 
   	@user.password = "a" * 200
   	assert_not @user.valid?
   end
   
   test "password should be present" do 
   	@user.password = "        "
   	assert_not @user.valid?
   end	

   test "email validation should accept valid addresses" do
   		valid_addresses = %w[user@example.com 	USER@foo.COM a-US_er@foo.bar.com
   											first.last@foo.jp jim+jom@baz.cn]
   		valid_addresses.each do |address|
   			@user.email = address
   			assert @user.valid?, " #{address.inspect} should be valid"
   		end		 									
   end	

   test "email validation should reject invalid addresses" do
   	invalid_addresses = %w[foobar foo@bar,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]

   	invalid_addresses.each do |address|
   		@user.email = address
   		assert_not @user.valid?, " #{address.inspect} should be invalid" 
   	end		
   end	

   test "email address should be unique" do 
   	duplicate_user = @user.dup 
   	duplicate_user.email = @user.email.upcase
   	@user.save
   	assert_not duplicate_user.valid?
   end	

   test "email address should be saved as lower case" do
   	mixed_case_email = "Foo@EXamplE.cOM" 
   	@user.email = mixed_case_email
   	@user.save
   	assert_equal  mixed_case_email.downcase, @user.reload.email
   end	

   test "posts destroyed when user deleted" do
      @user.save
      @user.posts.create!(content: "test post")
      assert_difference 'Post.count', -1 do 
         @user.destroy 
      end
   end      

end
