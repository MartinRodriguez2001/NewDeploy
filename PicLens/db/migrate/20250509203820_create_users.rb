class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :user_name
      t.string :email
      t.string :password
      t.string :bio
      t.string :photo_profile

      t.timestamps
    end
  end
end
