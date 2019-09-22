class User < ApplicationRecord
	before_save { self.email = email.downcase }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :timeoutable, :omniauthable

  validates :name, presence: true, length: { maximum: 50 }    
  validates :email, length: { maximum: 255 }   
end
