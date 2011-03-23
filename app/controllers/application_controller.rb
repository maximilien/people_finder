# 
# Main application controller (superclass for all others)
# @author E. M. Maximilien
# Copyright (C) IBM Corp., 2011
# License under the MIT license, found here: http://goo.gl/s9uhf
#

class ApplicationController < ActionController::Base
  include ApplicationHelper
  
  const_set 'SUPERUSER_FACEBOOK_IDS', [538750748] unless defined? SUPERUSER_FACEBOOK_IDS
  
  helper :all
  
  before_filter :ensure_application_is_installed_by_facebook_user
  before_filter :ensure_authenticated_to_facebook
  
  helper_attr :current_user
  attr_accessor :current_user
  
  before_filter :set_current_user, :reminders, :update_stats, :register_publish_action
  
  def default_admin_user_facebook_id
    538750748
  end
  
  def default_admin_user
    User.find_by_facebook_id 538750748
  end
  
  def current_user
    set_current_user if @current_user.nil?
    @current_user
  end
  
  protected
  
  def only_superusers?
    return if current_user.nil? or current_user.profile.nil?    
    redirect_to :controller => 'welcome', :action => 'index' unless current_user.superuser?
  end
  
  def parse_boolean value
    return false if value.nil?
    return true if value == '1' or value == 'true' or value == 'T'
    false
  end
  
  def set_current_user
    self.current_user = User.for facebook_session.user.to_i, facebook_session
    if SUPERUSER_FACEBOOK_IDS.include?(self.current_user.facebook_id) and !self.current_user.superuser?
      self.current_user.superuser = true
      self.current_user.save
    end
    @fb_user_info = facebook_session.user || 'facebooker_test_session.user'
  end
  
  def per_page
    5
  end
  
  def set_locations_tab
    @locations_tab = 'LocationsTab'
  end
  
  def set_survivors_tab
    @survivors_tab = 'SurvivorsTab'
  end
  
  def set_missing_tab
    @missing_tab = 'MissingTab'
  end
  
  def set_trapped_tab
    @trapped_tab = 'TrappedTab'
  end
  
  def set_injured_tab
    @injured_tab = 'InjuredTab'
  end
  
  def set_ok_well_tab
    @ok_well_tab = 'OkWellTab'
  end
  
  def set_other_tab
    @other_tab = 'OtherTab'
  end
  
  def set_friends_tab
    @friends_tab = 'FriendsTab'
  end
  
  def set_family_members_tab
    @family_memberrs_tab = 'FamilyMembersTab'
  end

  def set_survivor_updates_tab
    @survivor_updates_tab = 'SurvivorUpdatesTab'
  end
  
  def null? obj
    return (obj.nil? or obj.blank?)
  end
  
  def boolean? obj
    return false if obj.nil? or obj.blank? or obj == '0'
    return true
  end
  
  def reminders
    return if current_user.nil? or current_user.profile.nil?
    profile_update_reminder
  end
  
  def register_publish_action  
    return if current_user.nil? or current_user.profile.nil?
    reminder = Reminder.find :first, :conditions => ['kind = ?', Reminder::PUBLISH_ACTION_REGISTRATION]
    reminder ||= Reminder.new :kind => Reminder::PUBLISH_ACTION_REGISTRATION, :user_id => current_user.id, :total => 0
    if reminder.total == 0
      FeedPublisher.register_publish_action rescue logger.info "#{app_name}: error using FeedPublisher.register_publish_action"
      reminder.total += 1
      reminder.save
    end 
  end
  
  def update_stats
    return if current_user.nil? or current_user.profile.nil?
    recent_stat = Stat.find :first, :order => 'created_at DESC'
    if recent_stat.nil?
      recent_stat = create_stat
    else
      recent_stat = create_stat if recent_stat.created_at <= 12.hours.ago
    end
  end
  
  private
  
  def create_stat
    stat = Stat.create :users_count => User.count,
                       :locations_count => Location.count,
                       :survivors_count => Survivor.count,
                       :survivor_updates_count => SurvivorUpdate.count,
                       :user_id => current_user.id
    stat.save
  end
    
  def profile_update_reminder
    return if !current_user.get_or_create_profile.nil? and !current_user.profile.blank_reminder?
    reminder = Reminder.find :first, :conditions => ['kind = ? AND user_id = ?', Reminder::PROFILE_UPDATE, current_user.id]
    reminder ||= Reminder.new :kind => Reminder::PROFILE_UPDATE, :user_id => current_user.id, :total => 0
    if reminder.updated_at.nil? or ((Time.now - reminder.updated_at) > 3600 and reminder.total < Reminder::MAX_PROFILE_UPDATE_REMINDERS)
      reminder.total += 1
      reminder.save
      redirect_to :controller => 'profiles', :action => 'edit', :id => current_user.profile.id
    end 
  end
end