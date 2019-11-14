class AddAuthorToComments < ActiveRecord::Migration[6.0]
  def change
    add_reference :comments, :author, null: false
  end
  
end
