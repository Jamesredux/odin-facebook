class StaticPagesController < ApplicationController

  def home
  
  	if current_user
      @post = current_user.posts.build
  		@posts = current_user.posts.page(params[:page]).per(15)
  	end
  end

  def about
  end

  def contact
  	
  end
end
