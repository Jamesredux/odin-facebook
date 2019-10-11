class Request < ApplicationRecord
  belongs_to :user
  belongs_to :pending_friend, class_name: 'User'





  

  def accept
	 user.friends << pending_friend
	 destroy 
	end




end
