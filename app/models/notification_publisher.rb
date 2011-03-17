# 
# Facebook notification publisher
# @author E. M. Maximilien
# Copyright (C) IBM Corp., 2011
# License under the MIT license, found here: http://goo.gl/s9uhf
#

class NotificationPublisher < Facebooker::Rails::Publisher
  include ApplicationHelper
  
  def survivor_update_notification user, survivor_update
    send_as :notification 
    recipients recipients_facebook_ids_for_survivor_update user, survivor_update
    from user.facebook_session.user
    fbml <<-MESSAGE 
    <fb:fbml>
    updated survivor or victim #{link_to survivor_update.survivor.formatted_name, :controller => 'survivor_updates', :action => 'show', :id => survivor_update.id}.  New status is #{survivor_update.status} which is #{(survivor_update.confirmed? ? 'confirmed' : 'not confirmed')}#{(survivor_update.confirmed? ?  ' by ' + survivor_update.confirmation_source : '')}
    </fb:fbml>
    MESSAGE
  end
  
  def survivor_in_location_notification user, survivor
    send_as :notification
    recipients recipients_facebook_ids_for_location user, survivor.location
    from user.facebook_session.user
    fbml <<-MESSAGE 
    <fb:fbml>
    added a new survivor or victim #{link_to survivor_update.survivor.formatted_name, :controller => 'survivor_updates', :action => 'show', :id => survivor_update.id} in 
    location #{link_to survivor.location.name, :controller => 'locations', :action => 'show', :id => survivor.location.id} 
    </fb:fbml>
    MESSAGE
  end
  
  def survivor_update_story_template
    one_line_story_template "{*actor*} added a survivor or victim update on {*date*} using <a href='#{haiti_quake_survivors_url}'>#{app_name}</a>"
  end
  
  def survivor_update_story user, survivor_update
    send_as :user_action
    from user.facebook_session.user
    story_size ONE_LINE
    data :actor => "#{survivor_update.user.formatted_name}", :date => "#{survivor_update.updated_at.strftime(fmt='%b %d @ %I:%M %p')}"
  end
  
  def new_survivor_notification user, survivor
    send_as :notification 
    recipients user.facebook_id
    from user.facebook_session.user
    fbml <<-MESSAGE 
    <fb:fbml>
    added a new survivor or victim in the #{link_to app_name, haiti_quake_survivors_url} application.
    See <fb:name uid='#{user.facebook_id}' firstnameonly='true' linked='false' useyou='false'/>'s #{link_to 'survivor profile', :controller => 'profiles', :action => 'show', :id => survivor.user.profile.id}.
    </fb:fbml>
    MESSAGE
  end
  
  protected
  
  def recipients_facebook_ids_for_location user, location
    recepients_fb_ids = []
    recepients_fb_ids << location.user.id unless user.id == location.user.id
    location.survivors.each {|s| recepients_fb_ids << s.user.id unless user.id == s.user.id}
    recepients_fb_ids
  end
  
  def recipients_facebook_ids_for_survivor_update user, survivor_update
    recepients_fb_ids = []
    survivor_update.survivor.survivor_updates.each {|su| recepients_fb_ids << su.user.facebook_id unless su.user.id == user.id}
    recepients_fb_ids
  end
end