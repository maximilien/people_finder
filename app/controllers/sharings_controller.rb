class SharingsController < ApplicationController
  before_filter :set_sharings_tab
  
  def index
    @skate_rinks = SkateRink.find :all
    @shared_to = Sharing.find :all, :conditions => ["user_id = ?", current_user.id]
    @shared_with = Sharing.find :all, :conditions => ["shared_user_id = ?", current_user.id]
  end
  
  def share
    registration = Registration.find params[:id]
    sharing = find_or_create_sharing registration, params[:user_id]
    index
    render :action => 'index'
  end
  
  def remove
    sharing = Sharing.find params[:id]
    sharing.destroy unless sharing.nil?
    index
    render :action => 'index'
  end
  
  private
  
  def find_or_create_sharing registration, user_id
    sharing = Sharing.find :first, :conditions => ["user_id = ? and skate_cache_id = ?",
                                                   user_id, registration.skate.id]
    sharing ||= Sharing.create :skate_id => registration.skate.id,
                               :user_id => user_id,
                               :shared_user_id => current_user.id,
                               :created_at => Time.now
    sharing.updated_at = Time.now
    sharing.save!
    sharing
  end
  
  def set_sharings_tab
    @sharings_tab = 'SharingsTab'
  end
end