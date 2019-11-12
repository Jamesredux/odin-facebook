class PicPostsController < ApplicationController
	before_action :authenticate_user!, only: [:create, :destroy]
	before_action :correct_user, only: :destroy

	def new
		@pic_post = PicPost.new
	end

	def create
		@pic_post = current_user.pic_posts.build(post_params)
		@pic_post.image.attach(params[:pic_post][:image])
		if @pic_post.save
			flash[:success] = "Image Post created"
			redirect_to root_url
		else
			@feed = current_user.feed.page(params[:page]).per(15)
			render 'static_pages/home'
		end		
	end

	def destroy
		@pic_post.destroy
		flash[:success] = "Image Post deleted"
		redirect_to request.referrer || root_url
	end	

	def index
  	@pic_posts = current_user.pic_posts
  	#if @pic_posts
  	#	@pic_posts.order(:created_at).page(params[:page]).per(15)
  	# => end	
   
  end	

	private

	def post_params
		params.require(:pic_post).permit(:image)
	end

	def correct_user
		@pic_post = current_user.pic_posts.find_by(id:  params[:id])
		redirect_to root_url if @pic_post.nil?
	end
end
