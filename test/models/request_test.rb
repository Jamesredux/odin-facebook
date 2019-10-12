require 'test_helper'

class RequestTest < ActiveSupport::TestCase

  def setup
  	@user = users(:james)
  	@other_user = users(:dale)
  	@request = Request.new(user: @user, pending_friend: @other_user)
  end

  test "should be valid" do 
  	assert @request.valid?
  end	

  test "user should be present" do
  	@request.user = nil
  	assert_not @request.valid?
  end	

  test "pending friend should be present" do
  	@request.pending_friend = nil
  	assert_not @request.valid?
  end	

  test "pending_friend and user can not be the same" do 
  	@request.pending_friend = @user
  	assert_not @request.valid?
  end
  
  test "can not create duplicate request" do 
  	@request.save
  	@request_new = Request.new(user: @user, pending_friend: @other_user)
  	assert_not @request_new.valid?
  end		






end
