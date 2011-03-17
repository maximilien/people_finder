class AddTweetedToSurvivorUpdates < ActiveRecord::Migration
  def self.up
    add_column :survivor_updates, :tweeted, :boolean, :default => false
  end
  
  def self.down
    remove_column :survivor_updates, :tweeted
  end
end