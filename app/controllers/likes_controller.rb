class LikesController < ApplicationController

	def create
		@like = current_user.likes.build(like_params)
		if @like.save
			flash.now[:success] = "Post liked"
				respond_to do |format|
					format.html { redirect_to request.referrer || users_path, :notice => "Post sent" }
					format.js  
						end
			else
				flash[:error] = "error error error"
				redirect_to request.referrer || users_path
			end

	end	

	private

	def like_params
		params.require(:like).permit(:liker_id, :likeable_type, :likeable_id)
	end
end
