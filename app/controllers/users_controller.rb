class UsersController < ApplicationController
	before_action :authenticate_user!, only: [:index, :destroy]
  before_action :admin_user, only: :destroy

  def new
  	
  end

  def show
  	@user = User.find(params[:id])
    @friends = current_user.friends
    redirect_to root_url and return unless @user.confirmed?
    @posts = @user.posts.page(params[:page]).per(15)
    @pic_posts = @user.pic_posts.page(params[:page]).per(15)
    @user_feed = (@user.pic_posts + @user.posts).sort{ |a,b| a.created_at  <=> b.created_at }.reverse!
    @user_feed = Kaminari.paginate_array(@user_feed).page(params[:page]).per(15)
  end

  def index
  	@users = User.order(:created_at).page(params[:page]).per(15)
    #@request = Request.new
  end	

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User Deleted"
    redirect_to users_url
  end

  private

  def admin_user
    redirect_to(root_url) unless current_user.admin?
    
  end


end
