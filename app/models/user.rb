# 
# User model
# @author E. M. Maximilien
# Copyright (C) IBM Corp., 2011
# License under the MIT license, found here: 
#

class User < ActiveRecord::Base
  has_one :profile
  
  has_many :sharings
  has_many :notifications
  has_many :stats  
  has_many :locations
  has_many :reminders
  
  has_many :friends
  has_many :family_members
  
  has_many :survivors
  has_many :survivor_updates
  
  def has_friend? survivor
    !Friend.find(:first, :conditions => ['user_id = ? AND survivor_id = ?', self.id, survivor.id]).nil?
  end
  
  def has_family_member? survivor
    !FamilyMember.find(:first, :conditions => ['user_id = ? AND survivor_id = ?', self.id, survivor.id]).nil?
  end
  
  def added_survivors
    Survivor.find :all, :conditions => ['user_id = ?', self.id]
  end
  
  def added_survivor_updates
    SurvivorUpdate.find :all, :conditions => ['user_id = ?', self.id]
  end
  
  def email
    return 'No profile' if profile.nil?
    "#{profile.email.sub '@', ' _at_ '}"
  end
  
  def formatted_name
    return 'No profile' if profile.nil?
    "#{profile.first_name} #{profile.last_name}"
  end
  
  def get_or_create_profile
    if self.profile.nil?
      self.profile = Profile.create :user_id => self.id
      self.profile.save!
    end
    self.profile
  end
  
  def includes_notification? name
    return !Notification.find(:first, :conditions => ["user_id = ? and name = ?", self.id, name]).nil?
  end
  
  def recently_notified? name
    notification = find_create_user_notification name
    return false if notification.last_notified_on.nil?
    return notification.last_notified_on >= 1.day.ago && notification.last_notified_on < Time.now
  end
  
  def update_notification name
    notification = find_create_user_notification name
    notification.last_notified_on = Time.now
    notification.save!
  end
  
  def self.for facebook_id, facebook_session = nil
    returning find_or_create_by_facebook_id(facebook_id) do |user|
      unless facebook_session.nil?
        user.store_session facebook_session.session_key
        user.last_login_date = Time.now
        user.save
      end
    end
  end

  def store_session session_key
    if self.session_key != session_key
      update_attribute :session_key, session_key
    end
  end

  def facebook_session
    @facebook_session ||=  
      returning Facebooker::Session.create do |session| 
        session.secure_with! session_key, facebook_id, 1.day.from_now
      end
  end

  def has_profile?
    return !self.profile.nil? 
  end
  
  private
  
  def find_create_user_notification name
    notification = Notification.find :first, :conditions => ["user_id = ? and name = ?", self.id, name]
    notification = Notification.create(:name => name, :user_id => self.id) if notification.nil?
    notification
  end
end