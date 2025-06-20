class ChangeDefaultRoleToUser < ActiveRecord::Migration[8.0]
  def change
    change_column_default :users, :role, from: "regular", to: "user"
    execute "UPDATE users SET role = 'user' WHERE role = 'regular'"
  end
end
