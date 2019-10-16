require 'test_helper'

class PostsInterfaceTest < ActionDispatch::IntegrationTest
  
  	def setup
  		@user = users(:james)
  	end	


   test "post interface" do
     log_in_as(@user)
     get root_path
     assert_select 'nav.pagination'
     #invalid submission
     assert_no_difference 'Post.count' do 
     	post posts_path, params: { post: { content: "" } }
     end
     assert_select 'div#error_explanation'
     #valid submission	
     content = "This post you like is coming back in style"
     assert_difference 'Post.count', 1 do 
     	post posts_path, params: { post: { content: content } }
     end
     assert_redirected_to root_url
     follow_redirect!
     assert_match content, response.body
     #delete post
     assert_select 'a', text: 'delete'	
     first_post = @user.posts.page(1).first
     assert_difference 'Post.count', -1 do 
     	delete post_path(first_post)
     end
     # Visit different user, no delete links	
     get user_path(users(:gordon))
     assert_select 'a', text: 'delete', count: 0
     
   end
end