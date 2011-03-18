# 
# Migration class
# @author E. M. Maximilien
# Copyright (C) IBM Corp., 2011
# License under the MIT license, found here: http://goo.gl/s9uhf
#

class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|
      #Attributes
      t.string :salutation
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :suffix
      t.string :nickname
            
      t.string :city
      t.string :country

      t.string :email
      t.string :web_site_url
      t.string :blog_url
      t.string :twitter
      
      t.string :time_zone
      
      t.string :mobile_phone
      t.string :work_phone
      t.string :home_phone
      
      t.string :photo_url
      
      t.boolean :share_info_with_all, :default => true
      t.boolean :allow_comments, :default => true
            
      t.text :about_yourself
      
      t.timestamps
      
      #Associations
      t.integer :user_id
      t.integer :survivor_id
    end
    
    # Indexes
    add_index :profiles, :user_id
    add_index :profiles, :survivor_id
  end

  def self.down
    drop_table :profiles
  end
end
