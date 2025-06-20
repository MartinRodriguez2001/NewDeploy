class ChangeRoleToStringInUsers < ActiveRecord::Migration[6.0]
  def change
    # Solo cambiar el default si la columna role existe
    if column_exists?(:users, :role)
      change_column_default :users, :role, "user"
    end
  end
end

