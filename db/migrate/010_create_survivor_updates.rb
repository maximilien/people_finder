# 
# Migration class
# @author E. M. Maximilien
# Copyright (C) IBM Corp., 2011
# License under the MIT license, found here: http://goo.gl/s9uhf
#

class CreateSurvivorUpdates < ActiveRecord::Migration
  def self.up
    create_table :survivor_updates do |t|
      # Attributes
      t.string :status
      t.text :details
      t.boolean :confirmed
      t.string :confirmation_source
      t.boolean :allow_comments, :default => true
      
      t.timestamps
      
      # Assocations
      t.integer :user_id
      t.integer :survivor_id
    end
    
    # Indexes
    add_index :survivor_updates, :user_id
    add_index :survivor_updates, :survivor_id
  end
  
  def self.down
    drop_table :survivor_updates
  end
end
