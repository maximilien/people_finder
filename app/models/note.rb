# 
# Note model
# @author E. M. Maximilien
# Copyright (C) IBM Corp., 2011
# License under the MIT license, found here: http://goo.gl/s9uhf
#

class Note < ActiveRecord::Base
  belongs_to :user
  
  belongs_to :person
  belongs_to :linked_person,
             :class_name => 'Person', 
             :foreign_key => :linked_person_id
end