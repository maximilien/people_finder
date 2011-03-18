# 
# Migration class
# @author E. M. Maximilien
# Copyright (C) IBM Corp., 2011
# License under the MIT license, found here: http://goo.gl/s9uhf
#

class AddCitizenOfToProfiles < ActiveRecord::Migration
  def self.up
    add_column :profiles, :citizen_of, :string
  end
  
  def self.down
    remove_column :profiles, :citizen_of
  end
end