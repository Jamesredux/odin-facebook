class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable
  has_many :likes, as: :likeable

  has_many :likers, through: :likes

  has_one_attached :image

  default_scope -> { order(created_at: :desc) }

  validates :user_id, presence: true 
  validates :content, presence: true, length: { maximum: 1000 }
  validates :image,   content_type: { in: %w[image/jpeg image/gif image/png],
                                      message: "must be a valid image format" },
                      size:         { less_than: 3.megabytes,
                                      message:   "should be less than 3MB" }


  def display_image
 		image.variant(resize_to_limit: [500, 500] )  
  end    


  #post.liked_by method for like button??
  def liked_by?(user)
      self.liker_ids.include?(user.id)
      #likes.where(liker_id: user.id).exists?
  end  

  def find_like(user)

    @like = Like.find_by(likeable: self, liker: user)
    @like                                
  end         


  #method to create unique id for css as Picposts and Posts can have the same Id no
  #so that ajax can identify correct button
  def unique_id
    @id = "p"
    @id << self.id.to_s
  end                     
end
