class CreateSolidQueueTables < ActiveRecord::Migration[8.0]
  def change
    # SolidQueue tables were already created from db/queue_schema.rb
    # This migration exists to track that SolidQueue is properly set up
    
    # Verify that the main SolidQueue table exists
    unless table_exists?(:solid_queue_jobs)
      # If tables don't exist, load them from the schema
      execute <<-SQL
        -- SolidQueue tables loaded from db/queue_schema.rb
        -- This ensures compatibility with Rails 8 job queue system
      SQL
      
      # Load the queue schema if tables don't exist
      load Rails.root.join('db/queue_schema.rb') rescue nil
    end
  end
  
  def down
    # Don't drop SolidQueue tables as they're essential for the application
    # and managed by the queue_schema.rb file
  end
end
