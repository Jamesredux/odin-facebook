require 'test_helper'

class PostsInterfaceTest < ActionDispatch::IntegrationTest
  
  	def setup
  		@user = users(:james)
  	end	


   test "post interface" do
     log_in_as(@user)
     get root_path
     assert_select 'nav.pagination'
     assert_select 'input[type=file]'
     #invalid submission
     assert_no_difference 'Post.count' do 
    	post posts_path, params: { post: { content: "" } }
     end
     assert_select 'div#error_explanation'
     #valid submission	
     content = "This post you like is coming back in style"
     image = fixture_file_upload('test/fixtures/kitten.jpg', 'image/jpeg')
     assert_difference 'Post.count', 1 do 
     	post posts_path, params: { post: { content: content, image: image } }
     end
     post = assigns(:post)
     assert post.image.attached?
     assert_redirected_to root_url
     follow_redirect!
     assert_match content, response.body
     #delete post
     assert_select 'a', text: 'delete'	
     first_post = @user.posts.page(1).first
     assert_difference 'Post.count', -1 do 
     	delete post_path(first_post)

     end

     
   end

   test "home page should have feed" do 
    log_in_as(@user)
    get  root_path
    Kaminari.paginate_array(@user.feed).page(1).per(10) do |post|
        assert_match CGI.escapeHTML(post.content), response.body 
    end    
   end 

end
