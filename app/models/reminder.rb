class Reminder < ActiveRecord::Base
  const_set 'PROFILE_UPDATE', 'Profile.update' unless defined? PROFILE_UPDATE
  const_set 'PUBLISH_ACTION_REGISTRATION', 'FeedPublisher.publish_action_template' unless defined? PUBLISH_ACTION_REGISTRATION
  
  const_set 'KINDS', [PROFILE_UPDATE, PUBLISH_ACTION_REGISTRATION] unless defined? KINDS
  
  const_set 'MAX_PROFILE_UPDATE_REMINDERS', 7 unless defined? MAX_PROFILE_UPDATE_REMINDERS
  
  belongs_to :user
end