class Request < ApplicationRecord
  belongs_to :user
  belongs_to :pending_friend, class_name: 'User'


	validates_presence_of :user_id, :pending_friend_id
  validate :user_is_not_equal_pending_friend
  validates_uniqueness_of :user_id, scope: [:pending_friend_id] 
  validate :not_friends
  validate :not_pending


  

  def accept
  	
		 user.friends << pending_friend
	 	destroy 

	end


	private

	  def user_is_not_equal_pending_friend
     errors.add(:pending_friend, "can't send a request to yourself") if self.user == self.pending_friend
    end

    def not_friends
      if user && pending_friend
        errors.add(:pending_friend, "you are already friends") if user.friends.include?(pending_friend)
      end
    end

    def not_pending
      if user && pending_friend
        if pending_friend.pending_friends.include?(user) || user.pending_friends.include?(pending_friend)
           errors.add(:pending_friend, 'request already pending') 
       end
      end 
    end


end
