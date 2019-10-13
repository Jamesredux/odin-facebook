require 'test_helper'

class PostTest < ActiveSupport::TestCase

	def setup
		@user = users(:james)
		@post = @user.posts.build(content: "First post")
		
	end

	test "post should be valid" do 
		assert @post.valid?
	end
	
	test "user id should be present" do 
		@post.user_id = nil
		assert_not @post.valid?

	end	

	test "content should be present" do 
		@post.content = "  "
		assert_not @post.valid?
	end
	
	test "content should not be more than 1000 characters." do 
		@post.content = "tugboat" * 1000
		assert_not @post.valid?
	end	

	test  "order should be most recent first" do
		assert_equal posts(:most_recent), Post.first
	end 


end
