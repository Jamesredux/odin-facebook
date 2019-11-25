class Like < ApplicationRecord
  belongs_to :liker, class_name: 'User'
  belongs_to :likeable, polymorphic: true


  validates :likeable_id, presence: true
  validates :liker_id, presence: true

  validates :liker_id, :uniqueness => { :scope => [:likeable_type, :likeable_id] }
end
