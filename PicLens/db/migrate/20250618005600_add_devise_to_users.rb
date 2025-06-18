class AddDeviseToUsers < ActiveRecord::Migration[8.0]
  def self.up
    change_table :users do |t|
      unless column_exists?(:users, :reset_password_token)
        t.string   :reset_password_token
        t.datetime :reset_password_sent_at
      end

      unless column_exists?(:users, :remember_created_at)
        t.datetime :remember_created_at
      end

      unless column_exists?(:users, :sign_in_count)
        t.integer  :sign_in_count, default: 0, null: false
        t.datetime :current_sign_in_at
        t.datetime :last_sign_in_at
        t.string   :current_sign_in_ip
        t.string   :last_sign_in_ip
      end

      unless column_exists?(:users, :confirmation_token)
        t.string   :confirmation_token
        t.datetime :confirmed_at
        t.datetime :confirmation_sent_at
        t.string   :unconfirmed_email
      end
    end

    add_index :users, :reset_password_token, unique: true unless index_exists?(:users, :reset_password_token)
    add_index :users, :confirmation_token, unique: true unless index_exists?(:users, :confirmation_token)
  end

  def self.down
    remove_columns :users, :reset_password_token, :reset_password_sent_at, :remember_created_at,
                  :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip,
                  :last_sign_in_ip, :confirmation_token, :confirmed_at, :confirmation_sent_at,
                  :unconfirmed_email
  end
end
