class CreateNotifications < ActiveRecord::Migration
  def self.up
    create_table :notifications do |t|
      #Atrributes
      t.string :name
      t.datetime :last_notified_on
      
      #Associations
      t.integer :user_id
    end
    
    #Indexes
    add_index :notifications, :user_id
  end

  def self.down
    drop_table :notifications
  end
end