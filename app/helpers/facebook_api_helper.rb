# 
# Helper module for the Facebook API
# @author E. M. Maximilien
# Copyright (C) IBM Corp., 2011
# License under the MIT license, found here: http://goo.gl/s9uhf
#

module FacebookApiHelper
  def get_facebook_profile_info facebook_user
    profile_hash = {}
    profile_hash[:first_name] = facebook_user.first_name
    profile_hash[:last_name] = facebook_user.last_name
    profile_hash
  end
end