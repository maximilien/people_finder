class AddDuplicateToSurvivors < ActiveRecord::Migration
  def self.up
    add_column :survivors, :duplicate, :boolean, :default => false
  end
  
  def self.down
    remove_column :survivors, :duplicate
  end
end