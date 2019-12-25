class ApplicationController < ActionController::Base

	
 		before_action :request_count



 		

  	
  	def request_count
  	@incoming_count = Request.where(pending_friend: current_user).count
		
			
		end	
		

  		
end
