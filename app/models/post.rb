class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  default_scope -> { order(created_at: :desc) }

  validates :user_id, presence: true 
  validates :content, presence: true, length: { maximum: 1000 }
  validates :image,   content_type: { in: %w[image/jpeg image/gif image/png],
                                      message: "must be a valid image format" },
                      size:         { less_than: 3.megabytes,
                                      message:   "should be less than 3MB" }
end
