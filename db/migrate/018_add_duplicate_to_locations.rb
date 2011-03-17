class AddDuplicateToLocations < ActiveRecord::Migration
  def self.up
    add_column :locations, :duplicate, :boolean, :default => false
  end
  
  def self.down
    remove_column :locations, :duplicate
  end
end