# 
# Migration class
# @author E. M. Maximilien
# Copyright (C) IBM Corp., 2011
# License under the MIT license, found here: http://goo.gl/s9uhf
#

class AddDuplicateToSurvivors < ActiveRecord::Migration
  def self.up
    add_column :survivors, :duplicate, :boolean, :default => false
  end
  
  def self.down
    remove_column :survivors, :duplicate
  end
end