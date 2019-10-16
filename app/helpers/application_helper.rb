module ApplicationHelper

	#Method called in application layout to return default title or title probivided in view
	def full_title(page_title = '')
		base_title = "Odin-Facebook"
		if page_title.empty?
			base_title
		else
			page_title + " | " + base_title
		end		
	end

	def is_signed_in_user(user)
		user == current_user
	end


	private

	def requests_outstanding?
			true if Request.where(pending_friend: current_user).count > 0
	end
			
end
