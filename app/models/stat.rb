# 
# Stat model
# @author E. M. Maximilien
# Copyright (C) IBM Corp., 2011
# License under the MIT license, found here: 
#

class Stat < ActiveRecord::Base
  belongs_to :user
  
  def to_csv
 "#{self.created_at.to_s(:db)},#{self.users_count},#{self.locations_count},#{self.survivors_count},#{self.survivor_updates_count}"
  end
end