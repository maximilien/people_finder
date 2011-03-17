# 
# Notification model
# @author E. M. Maximilien
# Copyright (C) IBM Corp., 2011
# License under the MIT license, found here: http://goo.gl/s9uhf
#

class Notification < ActiveRecord::Base
  belongs_to :user
end
