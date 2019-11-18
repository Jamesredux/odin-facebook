class AddLikeableToLikes < ActiveRecord::Migration[6.0]
  def change
    add_reference :likes, :likeable, polymorphic: true, null: false
  end
end
