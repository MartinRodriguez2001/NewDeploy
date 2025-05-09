class CreateActivityHistories < ActiveRecord::Migration[8.0]
  def change
    create_table :activity_histories do |t|
      t.string :activity_type
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
