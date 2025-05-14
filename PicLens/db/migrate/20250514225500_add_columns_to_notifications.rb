class AddColumnsToNotifications < ActiveRecord::Migration[8.0]
  def change
    add_column :notifications, :message, :string
    add_column :notifications, :notifiable_type, :string
    add_column :notifications, :notifiable_id, :integer
    
    add_index :notifications, [:notifiable_type, :notifiable_id]
  end
end 