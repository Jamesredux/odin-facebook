class RequestsController < ApplicationController

	def new
		@request = Request.new
	end

	def index
		@incoming = Request.where(pending_friend: current_user)
		@outgoing = current_user.requests
		
	end

	def create
		@pending_friend = User.find(params[:request][:pending_friend])
		#check already friends or already outstanding request
		#user has already sent request or got request
		if request_already_sent(@pending_friend)
			flash[:warning] = "There is already a pending request sent to this user."
			redirect_to root_url
		elsif outstanding_incoming_request(@pending_friend)
			flash[:success] = "There is an outstanding friend request from this user
													would you like to accept it"	
			# redirect to requests page										
		else	
			@new_request = current_user.requests.new(pending_friend: @pending_friend)
			if @new_request.save
				#success
			redirect_to root_url
			else
			redirect_to user_path
			#what if it fails
			end
		end			
	end

	def destroy
		@request = Request.find(params[:id])
		if current_user == @request.user

			@request.destroy
			flash[:info] = "Request cancelled"
		else
			@request.destroy
			flash[:info] = "Request declined"
		end	
		redirect_to requests_path
	end

	def update
		
	end

	private

	def request_already_sent(pending_friend)
		current_user.pending_friends.include?(pending_friend)
	end

	def outstanding_incoming_request(pending_friend)
		pending_friend.pending_friends.include?(current_user)
		
	end
end
