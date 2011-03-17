class CreateSurvivors < ActiveRecord::Migration
  def self.up
    create_table :survivors do |t|
      #Attributes
      t.timestamps
      
      #Associations
      t.integer :user_id
      t.integer :location_id
    end
    
    #Indexes
    add_index :survivors, :user_id
    add_index :survivors, :location_id
  end
  
  def self.down
    drop_table :survivors
  end
end
