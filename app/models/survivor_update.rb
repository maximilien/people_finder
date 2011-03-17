class SurvivorUpdate < ActiveRecord::Base
  include ApplicationHelper
  include TwitterHelper
  include BitlyHelper
  include SurvivorHelper
  include SurvivorUpdateHelper
  
  belongs_to :survivor
  belongs_to :user
  
  acts_as_solr :fields => [:details, :status, :confirmation_source]
  
  attr_accessor :hidden_fields
  
  def self.non_tweeted
    SurvivorUpdate.find :all, :conditions => ['tweeted = ?', false]
  end
  
  def self.tweeted
    SurvivorUpdate.find :all, :conditions => ['tweeted = ?', true]
  end
  
  def self.by_user user
    SurvivorUpdate.find :all, :conditions => ['user_id = ?', user.id]
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
      self.survivor.update_attributes :tweeted => true unless self.survivor.tweeted?
    rescue
      logger.info "Could not tweet: #{tweet_text}"
    end
  end
  
  def feed_description
    html = "<p><b>Update on #{self.created_at.strftime(fmt='%b %d @ %I:%M %p')} by #{self.user.profile.formatted_name}</b></p>"
    html += '<p>'
    html += "<b>Name: </b> #{self.survivor.profile.formatted_name}<br/>" unless self.survivor.profile.nil?
    html += "<b>Status: </b> #{self.status}, <b>confirmed: </b>#{self.confirmed? ? 'yes' : 'no'}<br/>"
    html += "<b>Citizen of: </b> #{self.profile.citizen_of}<br/>" unless self.profile.citizen_of.nil? or self.profile.citizen_of.blank?
    if self.confirmed?
      html += "<b>Confirmation source: </b> #{self.confirmation_source}<br/>"  
    end
    html += "<b>Allow comments: </b> #{self.allow_comments? ? 'yes' : 'no'}<br/>"
    html += '</p>'
    html += %{<p><b>Details</b></p>
              <small>
              #{((self.details.nil? or self.details.blank?) ? '<i>Empty details</i>' : self.details)}
              </small>}
    html
  end

  private
  
  def show_url
    "#{haiti_quake_survivors_url}/survivor_updates/show/#{self.id}"
  end
  
  def create_tweet_text
    confirmed_by_text = (self.confirmed? and !self.confirmation_source.nil? and !self.confirmation_source.blank?) ? " confirmed by #{self.confirmation_source}" : ''
    text = "#{self.survivor.profile.formatted_name.strip}'s new status is #{self.status}#{confirmed_by_text} via #{app_name} app"
    hashtags = {:status => self.status}
    hashtags[:haiti] = 'Haiti' if (self.id % (rand(25) + 1) == 0)
    to_140 text, bitly_shorten(show_url), hashtags
  end
  
  def valid_kind
    errors.add_to_base 'Must be a valid survivor update kind' unless KINDS.include?(self.kind)
  end
end
