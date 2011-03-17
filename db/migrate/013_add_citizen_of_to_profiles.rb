class AddCitizenOfToProfiles < ActiveRecord::Migration
  def self.up
    add_column :profiles, :citizen_of, :string
  end
  
  def self.down
    remove_column :profiles, :citizen_of
  end
end