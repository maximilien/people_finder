# 
# Survivor model
# @author E. M. Maximilien
# Copyright (C) IBM Corp., 2011
# License under the MIT license, found here: 
#

class Survivor < ActiveRecord::Base
  include ApplicationHelper
  include TwitterHelper
  include BitlyHelper
  include SurvivorHelper
  
  has_one :profile
  
  has_many :survivor_updates
  
  has_many :friends
  has_many :family_members
  
  belongs_to :location
  belongs_to :user
  
  def self.create_from_hash hash
    location = Location.find_by_name(hash[:location]) || Location.default
    
    survivor = Survivor.create :location_id => location.id, 
                               :user_id => hash[:user_id]
                               
    survivor_update = SurvivorUpdate.create :status => hash[:status],
                                            :details => hash[:description],
                                            :confirmed => hash[:confirmed],
                                            :confirmation_source => hash[:confirmation_source],
                                            :survivor_id => survivor.id,
                                            :user_id => hash[:user_id]
    
    profile = Profile.create :salutation => hash[:salutation],  
                             :first_name => hash[:first_name], 
                             :middle_name => hash[:middle_name], 
                             :last_name => hash[:last_name], 
                             :suffix => hash[:suffix], 
                             :nickname => hash[:nickname], 
                             :citizen_of => hash[:citizen_of], 
                             :mobile_phone => hash[:mobile_phone],  
                             :home_phone => hash[:home_phone], 
                             :work_phone => hash[:work_phone], 
                             :survivor_id => survivor.id,
                             :user_id => hash[:user_id]
                             
    [survivor, profile, survivor_update, location]
  end
  
  def self.non_tweeted
    Survivor.find :all, :conditions => ['tweeted = ?', false]
  end
  
  def self.tweeted
    Survivor.find :all, :conditions => ['tweeted = ?', true]
  end
  
  def self.by_user user
    Survivor.find :all, :conditions => ['user_id = ?', user.id]
  end
  
  def tweet
    client = Twitter::Base.new twitter_http_auth
    tweet_text = create_tweet_text
    begin
      unless disable_twitter?
        client.update tweet_text
      else
        puts "tweet: #{tweet_text}"
      end
      self.update_attributes :tweeted => true
      self.survivor_updates.last.update_attributes :tweeted => true
    rescue
      logger.info "Could not tweet: #{tweet_text}"
    end
  end
  
  def self.missing order='updated_at ASC'
    survivors = []
    survivors = Survivor.find :all, :include => [:profile, :user],
                              :conditions => ['last_status = ?', Survivor::MISSING],
                              :order => order
    if survivors.nil? or survivors.empty?
      update_last_statuses
    end
    survivors
  end
  
  def self.trapped order='updated_at ASC'
    Survivor.find :all, :include => [:profile, :user],
                  :conditions => ['last_status = ?', Survivor::TRAPPED], 
                  :order => order
  end
  
  def self.injured order='updated_at ASC'
    Survivor.find :all, :include => [:profile, :user],
                  :conditions => ['last_status = ?', Survivor::INJURED], 
                  :order => order
  end
  
  def self.ok_well order='updated_at ASC'
    Survivor.find :all, :include => [:profile, :user],
                  :conditions => ['last_status = ? OR last_status = ?', 
                                  Survivor::OK, Survivor::WELL ], :order => order
  end
  
  def self.other order='updated_at ASC'
    Survivor.find :all, :include => [:profile, :user],
                  :conditions => ['last_status = ? OR last_status = ? OR last_status = ?',  Survivor::INJURED, Survivor::DECEASED_UNCONFIRMED, Survivor::DECEASED_CONFIRMED], 
                  :order => order
  end
  
  def name
    self.formatted_name
  end
  
  def formatted_name
    self.profile.formatted_name
  end
  
  def feed_description
    html = %{<p><b>Added on: </b>#{self.created_at.strftime(fmt='%b %d @ %I:%M %p')}</p>}
    html += "<b>Name: </b> #{self.profile.formatted_name}<br/>" unless self.profile.nil?
      html += %{
      <p><b>Current status: </b>#{self.survivor_updates.last.status}</p>}
      html += "<b>Citizen of: </b> #{self.profile.citizen_of}<br/>" unless self.profile.citizen_of.nil? or self.profile.citizen_of.blank?
      html += %{
      <p><b>No. of updates: </b>#{self.survivor_updates.size}</p>}
      unless self.survivor_updates.last.details.nil? or self.survivor_updates.last.details.blank?
        html += %{
      <p>
      Last update details: 
      <p><small>#{self.survivor_updates.last.details}</small></p>
      </p>}
    end
    html
  end
  
  private
  
  def self.update_last_statuses
    Survivor::STATUSES.each do |status|
      survivors = Survivor.find :all
      survivors.each do |survivor| 
        survivor.update_attribute(:last_status, survivor.survivor_updates.last.status) if survivor.last_status.nil? or survivor.last_status.blank? or survivor.survivor_updates.empty?
      end
    end
  end
  
  private
  
  def show_url
    "#{haiti_quake_survivors_url}/survivors/show/#{self.id}"
  end
  
  def create_tweet_text
    location_text = (self.location.nil? or self.location.name.nil? or self.location.name.blank?) ? '' : " last location in #{location.name.strip}"
    text = "#{self.profile.formatted_name.strip}'s status is #{self.last_status}#{location_text}, via #{app_name} app"
    hashtags = {:status => self.last_status}
    hashtags[:haiti] = 'Haiti' if (self.id % (rand(25) + 1) == 0)
    to_140 text, bitly_shorten(show_url), hashtags
  end
end