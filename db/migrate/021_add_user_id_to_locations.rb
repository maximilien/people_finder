# 
# Migration class
# @author E. M. Maximilien
# Copyright (C) IBM Corp., 2011
# License under the MIT license, found here: http://goo.gl/s9uhf
#

class AddUserIdToLocations < ActiveRecord::Migration
  def self.up
    add_column :locations, :user_id, :integer
  end
  
  def self.down
    remove_column :locations, :user_id
  end
end