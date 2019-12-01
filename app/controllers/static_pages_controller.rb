class StaticPagesController < ApplicationController

  def home
  
  	if current_user
      @post = current_user.posts.build
      @pic_post = current_user.pic_posts.build
      if current_user.feed
        @feed = current_user.feed
        @feed = Kaminari.paginate_array(@feed).page(params[:page]).per(15)
        
      end  
  	end
  end

  def about
  end

  def contact
  	
  end

  def privacy_policy
    
  end

  def tos
    
  end
end
