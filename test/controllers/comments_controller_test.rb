require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:james)
    @post = posts(:owl)
    log_in_as(@user)
  end



  test "should get show" do
    get comments_show_url
    assert_response :success
  end

  test "should get destroy" do
    get comments_destroy_url
    assert_response :success
  end

end
