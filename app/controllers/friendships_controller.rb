class FriendshipsController < ApplicationController




	def create
		@friend = User.find(params[:friendship][:friend]) 
		@friendship = Friendship.new(user: current_user, friend: @friend)
		if @friendship.save
			flash[:success] = "You are now friends"

			redirect_to root_url
		else
			flash[:danger] = "Friendship could not be created"
			redirect_to root_url
			@notice = @friendship.errors
		end		
		#User.friend_ids is a useful method
		#check friendship exists
		#create friendship
		#destroy friend request object
		#or error message if can't create friendship
	end

	def destroy
		
	end

	def show
		
	end

	def new
		@friendship = Friendship.new
	end
end
