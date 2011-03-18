# 
# Migration class
# @author E. M. Maximilien
# Copyright (C) IBM Corp., 2011
# License under the MIT license, found here: http://goo.gl/s9uhf
#

class AddTweetedToSurvivors < ActiveRecord::Migration
  def self.up
    add_column :survivors, :tweeted, :boolean, :default => false
  end
  
  def self.down
    remove_column :survivors, :tweeted
  end
end