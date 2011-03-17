# 
# Main application controller helper module
# @author E. M. Maximilien
# Copyright (C) IBM Corp., 2011
# License under the MIT license, found here: 
#

require File.dirname(__FILE__) + '/../../config/haiti_survivors'
require 'oauth'
require 'yaml'

module ApplicationHelper
  include FacebookerHelper
  include FeedsHelper
  include GoogleMapsHelper
  include BitlyHelper
  include TwitterHelper
  
  def site_blurb
  %{<p>
    The purpose of the #{app_name} is to help locate friends and family (we call them survivors because we are hopeful they are) who were in Haiti when the earthquake of January 12, 2010 hit.
    </p>
    <p>
    With #{app_name}, you can keep track of the status of friends and family as well as update and share information with Facebook friends. The main goal is to create a socially updated database of these “survivors” that is as accurate as possible, considering the current limited means of communications with Haiti.
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
    %{The purpose of the #{app_name} is to help locate friends and family (we call them survivors because we are hopeful they are) who were in Haiti when the earthquake of January 12, 2010 hit Haiti.}
  end
  
  def help_feedback_url
    "http://www.facebook.com/apps/application.php?api_key=8090a7f445674bafcd40039ad728a4a5"
  end
  
  def canvas_name
    CANVAS_NAME
  end
  
  def haiti_quake_survivors_bitly_url
    "http://bit.ly/4p8EqX"
  end
  
  def haiti_quake_survivors_twitter_url
    "http://twitter.com/#{twitter_http_info[:username]}"
  end
  
  def haiti_quake_survivors_url
    "http://apps.facebook.com/#{canvas_name}"
  end
  
  def haiti_quake_survivors_raw_url
    "http://#{DEFAULT_HOSTNAME_STRING}:#{DEFAULT_PORT_STRING}"
  end
  
  alias_method :haiti_quake_survivors_url, :haiti_quake_survivors_url
  alias_method :haiti_quake_survivors_raw_url, :haiti_quake_survivors_raw_url
  
  def haiti_quake_survivors_policy_url
    haiti_quake_survivors_raw_url + '/welcome/privacy_policy'
  end
  
  def haiti_quake_survivors_tou_url
    haiti_quake_survivors_raw_url + '/welcome/tou'
  end
  
  def haiti_quake_survivors_faq_url
    haiti_quake_survivors_raw_url + '/welcome/faq'
  end
  
  def app_name
    "Haiti Quake People Finder"
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