# 
# Migration class
# @author E. M. Maximilien
# Copyright (C) IBM Corp., 2011
# License under the MIT license, found here: http://goo.gl/s9uhf
#

class AddDuplicateToLocations < ActiveRecord::Migration
  def self.up
    add_column :locations, :duplicate, :boolean, :default => false
  end
  
  def self.down
    remove_column :locations, :duplicate
  end
end