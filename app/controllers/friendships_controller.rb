class FriendshipsController < ApplicationController
	before_action :authenticate_user!, only: [:index, :destroy]
	before_action :set_friend, only: :destroy

	def index
  	@friends = current_user.friends.page(params[:page]).per(15)
	end


	def destroy
		Friendship.find(params[:id]).destroy
		flash[:success] = "User Unfriended"
		redirect_to request.referrer || friendships_path	
	end


  	def create
			@friend = User.find(params[:friendship][:friend]) 
			@friendship = Friendship.new(user: current_user, friend: @friend)
				if @friendship.save
					flash[:success] = "You are now friends"

					redirect_to root_url
				else
					flash[:danger] = "Friendship could not be created"
					redirect_to users_path
					@notice = @friendship.errors
				end		
		end
	
	private


	def set_friend
	 	@friend = current_user.friends.find(params[:friendship][:friend])
	end


end
