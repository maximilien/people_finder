# 
# Person model
# @author E. M. Maximilien
# Copyright (C) IBM Corp., 2011
# License under the MIT license, found here: http://goo.gl/s9uhf
#

class Person < ActiveRecord::Base
  belongs_to :user
  belongs_to :survivor
  
  has_many :notes
end