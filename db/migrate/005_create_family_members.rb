class CreateFamilyMembers < ActiveRecord::Migration
  def self.up
    create_table :family_members do |t|
      #Attributes
      t.string :relashionship
      t.text :description
      
      t.timestamps
      
      #Associations
      t.integer :user_id
      t.integer :survivor_id
    end
    
    #Indexes
    add_index :family_members, :user_id
    add_index :family_members, :survivor_id
  end
  
  def self.down
    drop_table :family_members
  end
end
