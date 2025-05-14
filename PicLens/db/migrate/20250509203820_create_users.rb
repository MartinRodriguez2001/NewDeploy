class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :user_name, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.text :bio
      t.string :photo_profile
      t.boolean :is_private, default: false
      t.boolean :is_verified, default: false
      t.datetime :last_login_at
      t.string :reset_password_token
      t.datetime :reset_password_sent_at

      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, :user_name, unique: true
    add_index :users, :reset_password_token, unique: true
  end
end
