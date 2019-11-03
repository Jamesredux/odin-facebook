class StaticPagesController < ApplicationController

  def home
  
  	if current_user
      @post = current_user.posts.build
      if current_user.feed
        @feed = current_user.feed.page(params[:page]).per(15)
      end  
  	end
  end

  def about
  end

  def contact
  	
  end
end
