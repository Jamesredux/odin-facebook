  class Friendship < ApplicationRecord

	after_create :create_inverse_relationship
  after_destroy :destroy_inverse_relationship

  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validates_presence_of :user_id, :friend_id
  validate :user_is_not_equal_friend
  # validation below stops infinite after create loop. Can't create the same friendship twice
  validates_uniqueness_of :user_id, scope: [:friend_id] 






 private
  
  def user_is_not_equal_friend
    errors.add(:friend, "can't be the same as the user") if self.user == self.friend
  end

  def create_inverse_relationship
  	Friendship.create(user: friend, friend: user)
  end
  	
  def destroy_inverse_relationship
  	friendship = friend.friendships.find_by(friend: user)
    friendship.destroy if friendship
  end	
end
