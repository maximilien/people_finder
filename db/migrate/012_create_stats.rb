class CreateStats < ActiveRecord::Migration
  def self.up
    create_table :stats do |t|
      # Attributes
      t.integer :users_count
      t.integer :survivors_count
      t.integer :survivor_updates_count
      t.integer :locations_count

      t.timestamps
      
      # Assocations
      t.integer :user_id
    end
    
    # Indexes
    add_index :stats, :user_id
  end
  
  def self.down
    drop_table :stats
  end
end
