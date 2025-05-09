class CreateMessages < ActiveRecord::Migration[8.0]
  def change
    create_table :messages do |t|
      t.text :content
      t.references :chat, null: false, foreign_key: true
      t.integer :sender_id, null: false
      t.integer :receiver_id, null: false
      
      t.timestamps
    end
    
    add_index :messages, :sender_id
    add_index :messages, :receiver_id
  end
end
