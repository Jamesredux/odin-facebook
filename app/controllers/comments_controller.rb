class CommentsController < ApplicationController
	before_action :authenticate_user!, only: [:create, :destroy]
	before_action :correct_user, only: :destroy

  def create
  	#put object pic/picpost in commentable
  	#@post = Post.find(params[:comment][:commentable_id])
  	#@comment = @post.comments.build(comment_params)
  	@user = User.find(params[:comment][:author_id])
  	@comment = @user.comments.create(comment_params)
  	
  	if @comment.save
			flash[:success] = "Comment created"
			redirect_to request.referrer || root_url
		else
			@feed = current_user.feed.page(params[:page]).per(15)
			render 'static_pages/home'
		end		
  end

  def show
  end

  def destroy
  end

  private

  def comment_params
		params.require(:comment).permit(:content, :author_id, :commentable_type, :commentable_id)
	end

	def correct_user
		#method to check comment is own users
		#@comment = current_user.comments.find_by(id:  params[:id])
		#redirect_to root_url if @comment.nil?
	end
end
