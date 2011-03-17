class AddLastStatusToSurvivors < ActiveRecord::Migration
  def self.up
    add_column :survivors, :last_status, :string
  end
  
  def self.down
    remove_column :survivors, :last_status
  end
end