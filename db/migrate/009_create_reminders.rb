# 
# Migration class
# @author E. M. Maximilien
# Copyright (C) IBM Corp., 2011
# License under the MIT license, found here: http://goo.gl/s9uhf
#

class CreateReminders < ActiveRecord::Migration
  def self.up
    create_table :reminders do |t|
      # Attributes
      t.string :kind
      t.integer :total
      
      t.timestamps
      
      # Associations
      t.integer :user_id
    end
    
    # Indexes
    add_index :reminders, :user_id
  end
  
  def self.down
    drop_table :reminders
  end
end
