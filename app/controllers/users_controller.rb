class UsersController < ApplicationController
	before_action :authenticate_user!, only: [:index, :destroy]
  before_action :admin_user, only: :destroy

  def new
  	
  end

  def show
  	@user = User.find(params[:id])
    redirect_to root_url and return unless @user.confirmed?
  end

  def index
  	@users = User.order(:created_at).page(params[:page]).per(15)
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
