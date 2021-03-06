class LikesController < ApplicationController

	def create
		
		@like = current_user.likes.build(like_params)
		@post = find_post(@like)
		@post_unique_id = @post.unique_id
		if @like.save
			flash.now[:success] = "Post liked"
				respond_to do |format|
					format.html { redirect_to request.referrer || users_path, :notice => "Post sent" }
					format.js  
						end
			else
				flash[:error] = "Like failed"
				redirect_to request.referrer || root_url
			end

	end	


	def destroy
		@like = Like.find(params[:id])
		@post = find_post(@like)
		@post_unique_id = @post.unique_id
		@like.destroy
		flash[:info] = "Post unliked"
		respond_to do |format|
					format.html { redirect_to request.referrer || users_path, :notice => "Like removed" }
					format.js  
						end
	end



	def find_post(like)
		if like.likeable_type == "Post"
			@post = Post.find(like.likeable_id)
		else
			@post = PicPost.find(like.likeable_id)
		end
				

		#if params[:like][:likeable_type] == "Post"
	#		@post = Post.find(params[:like][:likeable_id])
	#	else
	#		@post = PicPost.find(params[:like][:likeable_id])
	#	end
		@post		
	end

	private



	def like_params
		params.require(:like).permit(:liker_id, :likeable_type, :likeable_id, :post)
	end
end
