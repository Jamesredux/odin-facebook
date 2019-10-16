class PostsController < ApplicationController
	before_action :authenticate_user!, only: [:create, :destroy]
	before_action :correct_user, only: :destroy

	def create
		@post = current_user.posts.build(post_params)
		@post.image.attach(params[:post][:image])
		if @post.save
			flash[:success] = "Post created"
			redirect_to root_url
		else
			@posts = @current_user.posts.page(params[:page]).per(15)
			render 'static_pages/home'
		end		
	end

	def destroy
		@post.destroy
		flash[:success] = "Post deleted"
		redirect_to request.referrer || root_url
	end	

	private

	def post_params
		params.require(:post).permit(:content, :image)
	end

	def correct_user
		@post = current_user.posts.find_by(id:  params[:id])
		redirect_to root_url if @post.nil?
	end
end
