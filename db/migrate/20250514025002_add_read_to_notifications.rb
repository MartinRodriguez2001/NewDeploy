class AddReadToNotifications < ActiveRecord::Migration[8.0]
  def change
    add_column :notifications, :read, :boolean
  end
end
