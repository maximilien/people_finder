# 
# Migration class
# @author E. M. Maximilien
# Copyright (C) IBM Corp., 2011
# License under the MIT license, found here: http://goo.gl/s9uhf
#

class CreateNotes < ActiveRecord::Migration
  def self.up
    create_table :notes do |t|
      #Attributes
      t.datetime :entry_date
      t.string :author_name
      t.string :author_email
      t.string :author_phone
      t.datetime :source_date
      t.boolean :found
      t.string :email_of_found_person
      t.string :phone_of_found_person
      t.string :last_known_location
      t.text :text
      
      t.timestamps
      
      #Associations
      t.string :person_id
      t.string :linked_person_id
    end
    
    # Indexes
    add_index :notes, :person_id
    add_index :notes, :linked_person_id
  end

  def self.down
    drop_table :notes
  end
end