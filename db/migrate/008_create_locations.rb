# 
# Migration class
# @author E. M. Maximilien
# Copyright (C) IBM Corp., 2011
# License under the MIT license, found here: http://goo.gl/s9uhf
#

class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.string :name
      t.string :nickname
      t.string :street1
      t.string :street2
      t.string :city
      t.string :country, :default => 'Haiti'
      t.string :kind
      t.string :web_site_url
      t.string :picture_url
      t.text :description
      
      t.timestamps
    end

    #Initial instances
    Location.create :name => 'No Location', :nickname => 'NONE', :kind => 'Region', :city => 'Port-au-Prince', :country => 'Haiti'
    Location.create :name => 'Delmas 83', :nickname => 'DEL', :kind => 'Region', :city => 'Port-au-Prince', :country => 'Haiti'
    Location.create :name => 'Petion Ville', :nickname => 'PV', :kind => 'City', :city => 'Petion Ville', :country => 'Haiti'
  end
  
  def self.down
    drop_table :locations
  end
end