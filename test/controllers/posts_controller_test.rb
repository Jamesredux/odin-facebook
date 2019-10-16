require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
 	
 	def setup
 		@post = posts(:owl)
 	end

 	test "should redirect create when not logged in" do 
 		assert_no_difference 'Post.count' do 
 			post posts_path, params: { post: { content: "Lorem ipsum" } }

 		end
 		assert_redirected_to new_user_session_path
 	end

 	test "should redirect destroy when not logged in" do 
 		assert_no_difference 'Post.count' do 
 			delete post_path(@post)
 		end		
 		assert_redirected_to new_user_session_path
 	end	

 	test "should redirect destroy for wrong user" do 
 		log_in_as(users(:james))
 		post = posts(:ants)
 		assert_no_difference 'Post.count' do 
 			delete post_path(post)
 		end
 		assert_redirected_to root_url
 	end		
end
