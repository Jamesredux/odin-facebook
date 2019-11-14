class Comment < ApplicationRecord

  belongs_to :commentable, polymorphic: true
  belongs_to :author, class_name: 'User'


  validates :content, presence: true, length: { maximum: 1000 }
  validates :commentable_id, presence: true
  validates :author_id, presence: true
end
