# 
# Migration class
# @author E. M. Maximilien
# Copyright (C) IBM Corp., 2011
# License under the MIT license, found here: http://goo.gl/s9uhf
#

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