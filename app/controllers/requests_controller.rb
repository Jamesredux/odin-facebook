class RequestsController < ApplicationController
		before_action :set_friend_request, except: [:index, :sent, :create]
		before_action :authenticate_user!



	def new
		@request = Request.new
	end

	def index
		@incoming = Request.where(pending_friend: current_user)
		
		
	end

	def sent
		@outgoing = current_user.requests
	end

	def create
		@pending_friend = User.find(params[:request][:pending_friend])

		@new_request = current_user.requests.new(pending_friend: @pending_friend)
			if @new_request.save
				flash[:success] = "Request sent"
				redirect_to users_path
			else
				flash[:error] = "Unable to send request"
				redirect_to users_path

			
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

end
