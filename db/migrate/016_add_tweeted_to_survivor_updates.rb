# 
# Migration class
# @author E. M. Maximilien
# Copyright (C) IBM Corp., 2011
# License under the MIT license, found here: http://goo.gl/s9uhf
#

class AddTweetedToSurvivorUpdates < ActiveRecord::Migration
  def self.up
    add_column :survivor_updates, :tweeted, :boolean, :default => false
  end
  
  def self.down
    remove_column :survivor_updates, :tweeted
  end
end