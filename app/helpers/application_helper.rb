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

end
