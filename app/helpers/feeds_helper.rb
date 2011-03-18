# 
# Helper module for the Feed Burner integration
# @author E. M. Maximilien
# Copyright (C) IBM Corp., 2011
# License under the MIT license, found here: http://goo.gl/s9uhf
#

module FeedsHelper
  def create_time datetime
    Time.mktime datetime.year, datetime.month, datetime.day, datetime.hour, datetime.min, datetime.sec, datetime.usec
  end
  
  def create_ical_time datetime
    datetime.strftime "%Y%m%dT%H%M%SZ"
  end
  
  def survivors_feedburner_url
    SURVIVORS_FEEDBURNER_URL
  end
  
  def survivors_and_victims_feedburner_url
    SURVIVORS_AND_VICTIMS_FEEDBURNER_URL   
  end
  
  def survivor_updates_missing_feedburner_url
    SURVIVOR_UPDATES_MISSING_FEEDBURNER_URL
  end
  
  def survivor_updates_ok_feedburner_url
    SURVIVOR_UPDATES_OK_FEEDBURNER_URL
  end
  
  def survivor_updates_injured_feedburner_url
    SURVIVOR_UPDATES_INJURED_FEEDBURNER_URL
  end
  
  def survivor_updates_other_feedburner_url
    SURVIVOR_UPDATES_OTHER_FEEDBURNER_URL
  end
end