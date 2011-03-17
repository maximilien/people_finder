class Profile < ActiveRecord::Base
  include ProfilesHelper

  belongs_to :user
  belongs_to :survivor

  acts_as_solr :fields => [:salutation, :first_name, :middle_name, :last_name, :suffix, :nickname, :country, :email, :mobile_phone, :home_phone, :work_phone]
    
  attr_accessor :superuser

  def full_name
    return "#{self.first_name} #{self.last_name} (#{self.nickname})" if !(self.first_name.nil? or self.first_name.blank?) and !(self.last_name.nil? or self.last_name.blank?) and !(self.nickname.nil? or self.nickname.blank?)
    return "#{self.first_name} #{self.last_name}" if !(self.first_name.nil? or self.first_name.blank?) and !(self.last_name.nil? or self.last_name.blank?) and (self.nickname.nil? or self.nickname.blank?)
    return "#{self.first_name}" if !(self.first_name.nil? or self.first_name.blank?) and (self.last_name.nil? or self.last_name.blank?)
    return "#{self.last_name}" if (self.first_name.nil? or self.first_name.blank?) and !(self.last_name.nil? or self.last_name.blank?)
    return "#{self.nickname}" unless self.nickname.nil? or self.nickname.blank?
    return "User_#{self.user.id}"
  end
  
  def formatted_name
    return "#{((self.salutation.nil? or self.salutation.blank?) ? '' : self.salutation + ' ')}#{((self.first_name.nil? or self.first_name.blank?) ? '' : self.first_name + ' ')}#{((self.middle_name.nil? or self.middle_name.blank?) ? '' : self.middle_name + ' ')}#{((self.last_name.nil? or self.last_name.blank?) ? '' : self.last_name)}#{((self.suffix.nil? or self.suffix.blank?) ? '' : ', ' + self.suffix)}#{((self.nickname.nil? or self.nickname.blank?) ? '' : ' (' + self.nickname + ')')}"
  end
  
  def blank?
    return [self.first_name, self.last_name].inject(false){|memo, a| memo ||= a.nil? or a.blank?}
  end
  
  def blank_reminder?
    return false
  end
  
  def superuser?
    self.user.superuser?
  end
  
  alias_method :superuser, :superuser?
  
  def superuser= b
    self.user.superuser = b
  end

  def feed_description
    html = %{<p>User since: <b>#{self.created_at.strftime(fmt='%b %y')}</b></p>}
    if self.share_info_with_all?

      html += %{

      <p>Country: #{self.country.nil? ? '<i>No country specified</i>' : self.country}</p>}

      html += %{
      <p>Allows comments: <b>#{self.allow_comments? ? 'yes' : 'no'}</b></p>}
    end
    html
  end

  private

  def validate_urls
    self.web_site_url = 'http://' + self.web_site_url if !self.web_site_url.nil? and !self.web_site_url.include?("http://") and !self.web_site_url.blank?
    self.blog_url = 'http://' + self.blog_url if !self.blog_url.nil? and !self.blog_url.include?("http://") and !self.blog_url.blank?
  end
end