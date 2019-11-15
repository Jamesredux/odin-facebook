class CommentsController < ApplicationController
  def create
  	@post = Post.find(params[:comment][:commentable_id])
  	@comment = @post.comments.build(comment_params)
  	
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
		params.require(:comment).permit(:content, :author_id, :commentable_id)
	end
end
