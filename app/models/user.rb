class User < ApplicationRecord
  has_many :comments, foreign_key: "author_id", dependent: :destroy
  has_many :likes, foreign_key: "liker_id", dependent: :destroy
  
  has_many :liked_posts, through: :likes, source: :likeable, source_type: :Post
  has_many :liked_pic_posts, through: :likes, source: :likeable, source_type: :PicPost

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  has_many :requests, dependent: :destroy
  has_many :pending_friends, through: :requests #, source: :pending_friend

  has_many :posts, dependent: :destroy
  has_many :pic_posts, dependent: :destroy
  


  has_one_attached :image

	before_save { self.email = email.downcase }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable :confirmable,
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :timeoutable, :confirmable, :lockable,
         :omniauthable, omniauth_providers: %i[facebook]

  validates :name, presence: true, length: { maximum: 50 }    
  validates :email, length: { maximum: 255 } 
  validates :image,   content_type: { in: %w[image/jpeg image/gif image/png],
                                      message: "must be a valid image format" },
                      size:         { less_than: 2.megabytes,
                                      message:   "should be less than 3MB" }


  def display_image(size = 50)
    image.variant(resize_to_limit: [size, size] )  
  end   


  def feed
   
    friend_ids = "SELECT friend_id FROM friendships
                 WHERE user_id = :user_id"

     @posts = Post.where("user_id IN (#{friend_ids}) 
                OR user_id  = :user_id", user_id: id) 
     @post_pics = PicPost.where("user_id IN (#{friend_ids}) 
                OR user_id  = :user_id", user_id: id)

     return (@posts + @post_pics).sort{ |a,b| a.created_at  <=> b.created_at }.reverse!
  end

  def user_feed
    (self.pic_posts + self.posts).sort{ |a,b| a.created_at  <=> b.created_at }.reverse!
  end


#this method was added for test/fixtures/users.yml but is not needed for that now, remove??
  def User.digest(string)
  	cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
  																							 BCrypt::Engine.cost
  	BCrypt::Password.create(string, cost: cost)																						 	
  end

  def self.from_omniauth(auth)
    where(provider: auth["provider"], uid: auth["uid"]).first_or_create do |user|
     user.email = auth.info.email
     user.password = Devise.friendly_token[0, 20]
     user.name = auth.info.name 
     user.image = auth.info.image
     user.skip_confirmation!  
   end
  end

  #called by the devise registrations controller
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end




end
