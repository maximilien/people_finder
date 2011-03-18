# 
# Main application controller helper module
# @author E. M. Maximilien
# Copyright (C) IBM Corp., 2011
# License under the MIT license, found here: http://goo.gl/s9uhf
#

require File.dirname(__FILE__) + '/../../config/people_finder'
require 'oauth'
require 'yaml'

module ApplicationHelper
  include FacebookerHelper
  include FeedsHelper
  include GoogleMapsHelper
  include BitlyHelper
  include TwitterHelper
  
  def disaster_country_name
    DISASTER_COUTRY_NAME
  end
  
  def disaster_date
    DISASTER_DATE
  end
  
  def site_blurb
  %{<p>
    The purpose of the #{app_name} is to help locate friends and family (we call them survivors because we are hopeful they are) who were in #{disaster_country_name} when the earthquake of #{disaster_date} hit.
    </p>
    <p>
    With #{app_name}, you can keep track of the status of friends and family as well as update and share information with Facebook friends. The main goal is to create a socially updated database of these “survivors” that is as accurate as possible, considering the current limited means of communications with #{disaster_country_name}.
    </p>}
  end
  
  def feedback_help_blurb
    %{<p>
    We welcome any <a href='#{help_feedback_url}'>feedback</a> you may have regarding this application and its
    usefulness.  If you encounter any technical difficulties with #{app_name}, you can post the 
    problems in the <a href='#{help_feedback_url}'>Help & Feedback</a> page.
    </p>}
  end
  
  def site_blurb_short
    %{The purpose of the #{app_name} is to help locate friends and family (we call them survivors because we are hopeful they are) who were in #{disaster_country_name} when the earthquake of #{disaster_date}.}
  end
  
  def help_feedback_url
   HELP_FEEDBACK_URL 
  end
  
  def canvas_name
    CANVAS_NAME
  end
  
  def people_finder_bitly_url
    BITLY_URL
  end
  
  def people_finder_twitter_url
    "http://twitter.com/#{twitter_http_info[:username]}"
  end
  
  def people_finder_url
    "http://apps.facebook.com/#{canvas_name}"
  end
  
  def people_finder_raw_url
    "http://#{DEFAULT_HOSTNAME_STRING}:#{DEFAULT_PORT_STRING}"
  end
  
  alias_method :people_finder_url, :people_finder_url
  alias_method :people_finder_raw_url, :people_finder_raw_url
  
  def people_finder_policy_url
    people_finder_raw_url + '/welcome/privacy_policy'
  end
  
  def people_finder_tou_url
    people_finder_raw_url + '/welcome/tou'
  end
  
  def people_finder_faq_url
    people_finder_raw_url + '/welcome/faq'
  end
  
  def app_name
    APP_NAME
  end
  
  def version
    VERSION_STRING
  end
  
  def max_news_feed_items
    7
  end

  def htmlize text
    return '' if text.nil?
    text.gsub(" ", "&nbsp;").gsub("\n", "<br/>")
  end
  
  def logger
    RAILS_DEFAULT_LOGGER
  end
  
  def disable_twitter?
    DISABLE_TWITTER
  end
  
  def twitter_enabled?
    !disable_twitter?
  end
end