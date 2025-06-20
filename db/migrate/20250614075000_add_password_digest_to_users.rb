class AddPasswordDigestToUsers < ActiveRecord::Migration[6.0]
  def change
    # Solo agregar si no existe
    add_column :users, :password_digest, :string unless column_exists?(:users, :password_digest)
  end
end
