class CreateFriends < ActiveRecord::Migration
  def self.up
    create_table :friends do |t|
      #Attributes
      t.string :level
      t.text :description
      
      t.timestamps
      
      #Associations
      t.integer :user_id
      t.integer :survivor_id
    end
    
    #Indexes
    add_index :friends, :user_id
    add_index :friends, :survivor_id    
  end
  
  def self.down
    drop_table :friends
  end
end
