class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      #Attributes
      t.integer :facebook_id, :limit => 8, :null => false 
      t.string :session_key
      t.boolean :superuser, :default => false
      t.datetime :last_login_date
      
      t.timestamps
    end
    
    #Indexes
    add_index :users, :facebook_id
  end
  
  def self.down
    drop_table :users
  end
end
