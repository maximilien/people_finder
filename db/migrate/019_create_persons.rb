# 
# Migration class
# @author E. M. Maximilien
# Copyright (C) IBM Corp., 2011
# License under the MIT license, found here: http://goo.gl/s9uhf
#

class CreatePersons < ActiveRecord::Migration
  def self.up
    create_table :persons do |t|
      #Attributes
      t.datetime :entry_date
      t.string :author_name
      t.string :author_email
      t.string :author_phone
      t.string :source_name
      t.datetime :source_date
      t.string :source_url
      t.string :first_name
      t.string :last_name
      t.string :home_city
      t.string :home_state
      t.string :home_neighborhood
      t.string :home_street
      t.string :home_zip
      t.string :photo_url
      t.text :other
      
      t.timestamps
      
      #Associations
      t.integer :user_id
      t.integer :survivor_id
    end
    
    # Indexes
    add_index :persons, :user_id
    add_index :persons, :survivor_id
  end

  def self.down
    drop_table :persons
  end
end