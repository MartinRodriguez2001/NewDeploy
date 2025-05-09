class CreateImages < ActiveRecord::Migration[8.0]
  def change
    create_table :images do |t|
      t.string :image_url
      t.integer :position
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
