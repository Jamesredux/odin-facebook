class RequestsController < ApplicationController
		before_action :set_friend_request, except: [:index, :create]
		before_action :authenticate_user!



	def new
		@request = Request.new
	end

	def index
		@incoming = Request.where(pending_friend: current_user)
		@outgoing = current_user.requests
		
	end

	def create
		@pending_friend = User.find(params[:request][:pending_friend])
		if already_friends(@pending_friend)
			#add notice
			flash[:warning] = "You are already friends"
			redirect_to users_path
		elsif request_already_sent(@pending_friend) || outstanding_incoming_request(@pending_friend)
			flash[:warning] = "There is an outstanding request for this user"
			redirect_to users_path

		#if request_already_sent(@pending_friend)
		#	flash[:warning] = "There is already a pending request sent to this user."
		#	redirect_to root_url
		#elsif outstanding_incoming_request(@pending_friend)
	#		flash[:success] = "There is an outstanding friend request from this user
	#												would you like to accept it"	
	#		redirect_to requests_path										
		else	
			@new_request = current_user.requests.new(pending_friend: @pending_friend)
			if @new_request.save
				flash[:success] = "Request sent"
			redirect_to users_path
			else
			#add error
			redirect_to user_path

			
			end
		end			
	end

	def destroy
		
		if current_user == @friend_request.user

			@friend_request.destroy
			flash[:info] = "Request cancelled"
		else
			@friend_request.destroy
			flash[:info] = "Request declined"
		end	
		redirect_to requests_path
	end

	def update
		@friend_request.accept
		flash[:success] = "Friendship created"
		redirect_to requests_path
	end



	private

	def set_friend_request
		@friend_request = Request.find(params[:id])
	end



	def request_already_sent(pending_friend)
		#need to add custom notice
		current_user.pending_friends.include?(pending_friend)
	end

	def outstanding_incoming_request(pending_friend)
		#need to add custom notice
		pending_friend.pending_friends.include?(current_user)
		
	end

	  def already_friends(pending_friend)
  	
  		current_user.friends.include?(pending_friend)
  	
  	end
end
