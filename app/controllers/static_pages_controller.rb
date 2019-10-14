class StaticPagesController < ApplicationController
  def home
  	@current_user = current_user
  	if @current_user
  		@posts = @current_user.posts.page(params[:page]).per(15)
  	end
  end

  def about
  end

  def contact
  	
  end
end
