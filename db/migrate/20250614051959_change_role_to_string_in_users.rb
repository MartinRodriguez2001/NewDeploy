class ChangeRoleToStringInUsers < ActiveRecord::Migration[6.0]
  def change
    change_column_default :users, :role, "user"
    add_column :users, :banned, :boolean, default: false
  end
end

