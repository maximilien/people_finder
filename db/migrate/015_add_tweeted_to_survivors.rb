class AddTweetedToSurvivors < ActiveRecord::Migration
  def self.up
    add_column :survivors, :tweeted, :boolean, :default => false
  end
  
  def self.down
    remove_column :survivors, :tweeted
  end
end