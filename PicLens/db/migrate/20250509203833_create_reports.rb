class CreateReports < ActiveRecord::Migration[8.0]
  def change
    create_table :reports do |t|
      t.string :reason
      t.string :status
      t.integer :reporter_id, null: false
      t.integer :reported_user_id, null: false
      
      t.timestamps
    end
    
    add_index :reports, :reporter_id
    add_index :reports, :reported_user_id
  end
end
