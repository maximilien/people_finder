# 
# Migration class
# @author E. M. Maximilien
# Copyright (C) IBM Corp., 2011
# License under the MIT license, found here: http://goo.gl/s9uhf
#

class AddLastStatusToSurvivors < ActiveRecord::Migration
  def self.up
    add_column :survivors, :last_status, :string
  end
  
  def self.down
    remove_column :survivors, :last_status
  end
end