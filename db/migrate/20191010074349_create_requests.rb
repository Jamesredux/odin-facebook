class CreateRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :requests do |t|
      t.references :user, null: false, foreign_key: true
      t.references :pending_friend, null: false

      t.timestamps
    end
    add_foreign_key :requests, :users, column: :pending_friend_id
  end
end
