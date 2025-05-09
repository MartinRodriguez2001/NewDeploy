class CreateChats < ActiveRecord::Migration[8.0]
  def change
    create_table :chats do |t|
      t.integer :user_id1, null: false
      t.integer :user_id2, null: false
      
      t.timestamps
    end
    
    add_index :chats, :user_id1
    add_index :chats, :user_id2
    add_index :chats, [:user_id1, :user_id2], unique: true
  end
end