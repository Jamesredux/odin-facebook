class AddConfirmableToDevise < ActiveRecord::Migration[6.0]
  def up
  	add_column :users, :unconfirmed_email, :string

  	User.update_all confirmed_at: DateTime.now
  end

  def down
  	remove_columns :users, :confirmation_token, :confirmed_at, :confirmation_sent_at
    remove_columns :users, :unconfirmed_email
  end
end
