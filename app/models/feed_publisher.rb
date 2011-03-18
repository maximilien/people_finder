# 
# Facebook Feed publisher
# @author E. M. Maximilien
# Copyright (C) IBM Corp., 2011
# License under the MIT license, found here: http://goo.gl/s9uhf
#

class FeedPublisher < Facebooker::Rails::Publisher
  include ApplicationHelper
  
  def publish_action_template
    one_line_story_template "{*actor*} is a new {*kind*} in {*app_link*} application, view {*first_name*}'s {*profile_link*}"
  end
  
  def new_survivor_feed_template
    one_line_story_template "{*actor*} is a new survivor in {*app_link*} application, view {*first_name*}'s {*profile_link*}"
  end
  
  def new_survivor_feed user
    send_as :user_action 
    from user.facebook_session.user
    story_size ONE_LINE
    data :app_link => "#{link_to app_name, people_finder_url}",
         :kind => 'survivor',
         :first_name => "#{user.profile.first_name}",
         :profile_link => "#{link_to 'profile', :controller => 'profiles', :action => 'show', :id => user.profile.id}"
  end
end