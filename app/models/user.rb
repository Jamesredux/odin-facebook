class User < ApplicationRecord
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  has_many :requests, dependent: :destroy
  has_many :pending_friends, through: :requests #, source: :pending_friend

  has_many :posts, dependent: :destroy


	before_save { self.email = email.downcase }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable :confirmable,
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :timeoutable, :omniauthable, :confirmable, :lockable

  validates :name, presence: true, length: { maximum: 50 }    
  validates :email, length: { maximum: 255 }   


  def feed
    Post.where("user_id = ?", id) 
  end


#this method was added for test/fixtures/users.yml but is not needed for that now, remove??
  def User.digest(string)
  	cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
  																							 BCrypt::Engine.cost
  	BCrypt::Password.create(string, cost: cost)																						 	
  end


end
