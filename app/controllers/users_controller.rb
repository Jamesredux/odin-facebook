class UsersController < ApplicationController
	before_action :authenticate_user!, only: [:index]

  def new
  	
  end

  def show
  	@user = User.find(params[:id])

  end

  def index
  	@users = User.all
  end	


end
