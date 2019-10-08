class FriendshipsController < ApplicationController


	def create
		Friendship.create(user: User.first, friend: User.find(66))
		redirect_to root_url
		#User.friend_ids is a useful method
		#check friendship exists
		#create friendship
		#destroy friend request object
		#or error message if can't create friendship
	end

	def destroy
		
	end
end
