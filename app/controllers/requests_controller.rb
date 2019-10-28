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
		@pending_friend = User.find(params[:pending_friend])
		@pendingfriend_id = @pending_friend.id
		@new_request = current_user.requests.new(pending_friend: @pending_friend)
			if @new_request.save
				
				respond_to do |format|
					format.html { redirect_to request.referrer || users_path, flash[:success] = "Request sent" }
					format.js { flash.now[:success] = "Request sent" }
				end
			else
				flash[:error] = "Unable to send request"
				redirect_to request.referrer || users_path
			end
				
	end

	def destroy
		@pending_friend = @friend_request.pending_friend
		@pendingfriend_id = @pending_friend.id
		if current_user == @friend_request.user

			@friend_request.destroy
			flash.now[:info] = "Request cancelled"
		else
			@friend_request.destroy
			flash[:info] = "Request declined"
		end	
		respond_to do |format|
			format.html { redirect_to request.referrer || requests_path }
			format.js
		end	
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
