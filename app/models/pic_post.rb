class PicPost < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable

  has_many :likes, as: :likeable
  has_many :likers, through: :likes
  
  has_one_attached :image

  default_scope -> { order(created_at: :desc) }

  validates :user_id, presence: true   
  validates :image, presence: true,  content_type: { in: %w[image/jpeg image/gif image/png],
                                      message: "must be a valid image format" },
                      size:         { less_than: 3.megabytes,
                                      message:   "should be less than 3MB" }


  def display_image
 		image.variant(resize_to_limit: [500, 500] )  
  end       

    #post.liked_by method for like button??
  def liked_by?(user)
      Like.where(liker_id: user.id).exists?
  end 

  def find_like(user)
    @like = likes.find_by(liker_id: user.id)
    @like.id                                
  end                    
end
