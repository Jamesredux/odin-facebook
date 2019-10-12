class Request < ApplicationRecord
  belongs_to :user
  belongs_to :pending_friend, class_name: 'User'


	validates_presence_of :user_id, :pending_friend_id
  validate :user_is_not_equal_pending_friend
  # validation below stops infinite after create loop. Can't create the same friendship twice
  validates_uniqueness_of :user_id, scope: [:pending_friend_id] 


  

  def accept
  	
		 user.friends << pending_friend
	 	destroy 

	end


	private

	  def user_is_not_equal_pending_friend
    errors.add(:pending_friend, "can't send a request to yourself") if self.user == self.pending_friend
  end



end
