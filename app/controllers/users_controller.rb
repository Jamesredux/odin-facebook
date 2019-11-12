class UsersController < ApplicationController
	before_action :authenticate_user!, only: [:index, :destroy]
  before_action :admin_user, only: :destroy

  def new
  	
  end

  def show
  	@user = User.find(params[:id])
    @friends = current_user.friends
    redirect_to root_url and return unless @user.confirmed? 
    @user_feed = Kaminari.paginate_array(@user.user_feed).page(params[:page]).per(15)
  end

  def index
  	@users = User.order(:created_at).page(params[:page]).per(15)
   
  end	

  def edit
    @user = User.find(params[:id])
  end  

  def update
    @user = User.find(params[:id])
    @user.image.attach(params[:user][:image])
    if @user.save
      flash[:success] = "Avatar added"
      redirect_to request.referrer || user_path
    else
     
      render 'static_pages/home'
    end   
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
