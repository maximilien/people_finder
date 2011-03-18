# 
# Migration class
# @author E. M. Maximilien
# Copyright (C) IBM Corp., 2011
# License under the MIT license, found here: http://goo.gl/s9uhf
#

class AddSessionTable < ActiveRecord::Migration
  def self.up
    create_table :sessions do |t|
      t.string :session_id, :null => false
      t.text :data
      
      t.timestamps
    end
    
    #Indexes
    add_index :sessions, :session_id
    add_index :sessions, :updated_at
  end
  
  def self.down
    drop_table :sessions
  end
end
