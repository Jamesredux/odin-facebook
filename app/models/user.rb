class User < ApplicationRecord
	before_save { self.email = email.downcase }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable :confirmable,
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :timeoutable, :omniauthable, :confirmable

  validates :name, presence: true, length: { maximum: 50 }    
  validates :email, length: { maximum: 255 }   


#this method was added for test/fixtures/users.yml but is not needed for that now, remove??
  def User.digest(string)
  	cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
  																							 BCrypt::Engine.cost
  	BCrypt::Password.create(string, cost: cost)																						 	
  end
end
