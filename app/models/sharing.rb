# 
# Sharing model
# @author E. M. Maximilien
# Copyright (C) IBM Corp., 2011
# License under the MIT license, found here: 
#

class Sharing < ActiveRecord::Base
  belongs_to :survivor_update
  belongs_to :user
  belongs_to :shared_user,
             :class_name => 'User', 
             :foreign_key => :shared_user_id
end
