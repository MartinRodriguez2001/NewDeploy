class FixDevisePasswordColumns < ActiveRecord::Migration[8.0]
  def up
    # Agregar encrypted_password para Devise si no existe
    unless column_exists?(:users, :encrypted_password)
      add_column :users, :encrypted_password, :string, null: false, default: ""
    end
    
    # Remover password si existe (no es compatible con Devise)
    if column_exists?(:users, :password)
      remove_column :users, :password
    end
    
    # Remover password_digest si existe (solo para has_secure_password)
    if column_exists?(:users, :password_digest)
      remove_column :users, :password_digest
    end
  end

  def down
    # Revertir cambios
    add_column :users, :password_digest, :string unless column_exists?(:users, :password_digest)
    remove_column :users, :encrypted_password if column_exists?(:users, :encrypted_password)
  end
end
