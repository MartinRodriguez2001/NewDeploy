class CreateFollowers < ActiveRecord::Migration[8.0]
  def change
    create_table :followers do |t|
      t.integer :follower_id, null: false
      t.integer :followed_id, null: false
      
      t.timestamps
    end
    
    add_index :followers, :follower_id
    add_index :followers, :followed_id
    add_index :followers, [:follower_id, :followed_id], unique: true
  end
end