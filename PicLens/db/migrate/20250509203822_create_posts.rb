class CreatePosts < ActiveRecord::Migration[8.0]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.text :caption
      t.string :location
      t.integer :image_count, default: 0
      t.boolean :is_private, default: false
      t.integer :likes_count, default: 0
      t.integer :comments_count, default: 0
      t.datetime :published_at

      t.timestamps
    end

    add_index :posts, :published_at
    add_index :posts, :location
  end
end
