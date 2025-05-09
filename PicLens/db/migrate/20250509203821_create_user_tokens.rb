class CreateUserTokens < ActiveRecord::Migration[8.0]
  def change
    create_table :user_tokens do |t|
      t.string :token
      t.datetime :expires_at
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
