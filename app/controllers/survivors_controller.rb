# 
# Controller for the Survivor model
# @author E. M. Maximilien
# Copyright (C) IBM Corp., 2011
# License under the MIT license, found here: 
#

class SurvivorsController < ApplicationController
  include SearchableHelper
  include TwitterHelper
  
  before_filter :set_survivors_tab, 
                :except => [:missing, :trapped, :injured, :ok_well, :other]
  
  before_filter :'only_superusers?', :only => [:tweet, :randomly_tweet]
  
  def randomly_tweet
    @number = params[:number].to_i
    @survivors = Survivor.non_tweeted
    @max_tweet = generate_random_tweets @survivors, @number
    flash[:notice] = "Generated #{@max_tweet} survivor tweets"
    redirect_to :action => 'index'
  end
  
  def remove_duplicate
    @survivor = Survivor.find params[:id]
    @survivor.update_attributes :duplicate => false
    redirect_to :action => 'show'
  end
  
  def duplicate
    @survivor = Survivor.find params[:id]
    @survivor.update_attributes :duplicate => true
    redirect_to :action => 'show'
  end
  
  def tweet
    @survivor = Survivor.find params[:id]
    @survivor.tweet unless !current_user.superuser? and @survivor.last_status == Survivor::DECEASED_UNCONFIRMED
    redirect_to :action => 'index'
  end
  
  def missing
    order = params[:order] || 'updated_at ASC'
    @survivors = Survivor.missing order
    set_missing_tab
    
    respond_to do |format|
      format.fbml
    end
  end
  
  def trapped
    order = params[:order] || 'updated_at ASC'
    @survivors = Survivor.trapped order
    set_trapped_tab
    
    respond_to do |format|
      format.fbml # trapped.fbml.erb
    end
  end
  
  def injured
    order = params[:order] || 'updated_at ASC'
    @survivors = Survivor.injured order
    set_injured_tab
    
    respond_to do |format|
      format.fbml # injured.fbml.erb
    end
  end
  
  def ok
    order = params[:order] || 'updated_at ASC'
    @survivors = Survivor.ok_well order
    set_ok_well_tab
    
    respond_to do |format|
      format.fbml # ok_well.fbml.erb
    end
  end
  
  def ok_well
    order = params[:order] || 'updated_at ASC'
    @survivors = Survivor.ok_well order
    set_ok_well_tab
    
    respond_to do |format|
      format.fbml # ok_well.fbml.erb
    end
  end
  
  def other
    order = params[:order] || 'updated_at ASC'
    @survivors = Survivor.other order
    set_other_tab
    
    respond_to do |format|
      format.fbml # other.fbml.erb
    end
  end
  
  def add_as_family_member
    @survivor = Survivor.find params[:id]
    @family_member = FamilyMember.find :first, :conditions => ['user_id = ? AND survivor_id = ?', current_user.id, @survivor.id]
    @family_member ||= FamilyMember.create :user_id => current_user.id,
                                           :survivor_id => @survivor.id
  end
  
  def add_as_friend
    @survivor = Survivor.find params[:id]
    @friend = Friend.find :first, :conditions => ['user_id = ? AND survivor_id = ?', current_user.id, @survivor.id]
    @friend ||= Friend.create :user_id => current_user.id,
                              :survivor_id => @survivor.id
  end
  
  def remove
    @survivor = Survivor.find(params[:id])
    @survivor.survivor_updates.each {|survivor_update| survivor_update.destroy unless survivor_update.nil?}    
    @survivor.profile.destroy unless @survivor.profile.nil?
    @survivor.destroy unless @survivor.nil?

    respond_to do |format|
      format.fbml { redirect_to(survivors_url) }
      format.xml  { head :ok }
    end
  end
  
  def duplicates
    @survivor = Survivor.new(params[:survivor])
    @survivor_update = SurvivorUpdate.new(params[:survivor_update])
    @profile = Profile.new(params[:profile])
    
    @survivor.user = current_user
    @survivor_update.user = current_user
    @survivor.profile = @profile
    @survivor.last_status = @survivor_update.status
    @survivor.survivor_updates << @survivor_update
    
    respond_to do |format|
      if @survivor.save and @survivor_update.save and @profile.save
        @survivor.tweet unless @survivor.last_status == SurvivorUpdate::DECEASED_UNCONFIRMED
        flash[:notice] = 'Survivor was successfully created.'
        format.fbml { redirect_to(@survivor) }
        format.xml  { render :xml => @survivor, 
                             :status => :created, :location => @survivor}
      else
        format.fbml { render :action => "new" }
        format.xml  { render :xml => @survivor.errors, 
                             :status => :unprocessable_entity }
      end
    end
  end

  # GET /survivors
  # GET /survivors.xml
  def index
    order = params[:order] || 'updated_at DESC'
    @survivors = Survivor.paginate :page => params[:page], 
                                   :per_page => per_page, 
                                   :order => order, 
                                   :include => [:profile, :location, :user]
    @locations = Location.find :all, :order => 'name ASC'
    
    respond_to do |format|
      format.fbml # index.fbml.erb
      format.xml  { render :xml => @survivors }
    end
  end
  
  # GET /survivors/1
  # GET /survivors/1.xml
  def show
    @survivor = Survivor.find(params[:id])
    
    respond_to do |format|
      format.fbml # show.fbml.erb
      format.xml  { render :xml => @survivor}
    end
  end
  
  # GET /survivors/new
  # GET /survivors/new.xml
  def new
    status = params[:status] || SurvivorUpdate::MISSING
    @locations = Location.find(:all, :order => ['name ASC'])
    @survivor = Survivor.new :location_id => Location.default.id
    @survivor.last_status = status
    @survivor_update = SurvivorUpdate.new :status => status
    @profile = Profile.new
    
    respond_to do |format|
      format.fbml # new.fbml.erb
      format.xml  { render :xml => @survivor}
    end
  end
  
  # GET /survivors/1/edit
  def edit
    @survivor = Survivor.find(params[:id])
    @locations = Location.find :all, :order => 'name ASC'
  end
  
  # POST /survivors
  # POST /survivors.xml
  def create
    @survivor = Survivor.new(params[:survivor])
    @survivor_update = SurvivorUpdate.new(params[:survivor_update])
    @profile = Profile.new(params[:profile])
    
    @duplicate_profiles = find_duplicate_profiles @profile
    
    @survivor.user = current_user
    @survivor_update.user = current_user
    @survivor.profile = @profile
    @survivor.last_status = @survivor_update.status
    @survivor.survivor_updates << @survivor_update
    
    respond_to do |format|
      if @duplicate_profiles.size > 0 and params[:commit] == 'Create'
        @duplicate_survivors = @duplicate_profiles.collect{|p| p.survivor}
        @locations = Location.find(:all, :order => ['name ASC'])
        flash[:notice] = "Found #{@duplicate_profiles} potential duplicates"
        format.fbml { render :action => "duplicates" }
        format.xml  { render :xml => @survivor.errors, :status => :unprocessable_entity }        
      elsif @survivor.save and @survivor_update.save and @profile.save
        @survivor.tweet unless @survivor.last_status == SurvivorUpdate::DECEASED_UNCONFIRMED
        begin
          NotificationPublisher.deliver_survivor_in_location_notification current_user, @survivor
        rescue
          logger.info "#{app_name}: error trying to invoke NotificationPublisher.deliver_survivor_in_location_notification"
        end
        flash[:notice] = 'Survivor was successfully created.'
        format.fbml { redirect_to(@survivor) }
        format.xml  { render :xml => @survivor, :status => :created, :location => @survivor}
      else
        format.fbml { render :action => "new" }
        format.xml  { render :xml => @survivor.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /survivors/1
  # PUT /survivors/1.xml
  def update
    @survivor = Survivor.find(params[:id])
    @profile = @survivor.profile
    
    @survivor.location = Location.find(params[:survivor][:location_id]); params[:survivor].delete(:location_id)
    
    respond_to do |format|
      if @survivor.update_attributes(params[:survivor]) and @profile.update_attributes(params[:profile])
        flash[:notice] = 'Survivor was successfully updated.'
        format.fbml { redirect_to(@survivor) }
        format.xml  { head :ok }
      else
        format.fbml { render :action => "edit" }
        format.xml  { render :xml => @survivor.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # DELETE /survivors/1
  # DELETE /survivors/1.xml
  def destroy
    @survivor = Survivor.find(params[:id])
    @survivor.destroy
    
    respond_to do |format|
      format.fbml { redirect_to(survivors_url) }
      format.xml  { head :ok }
    end
  end
  
  protected
  
  def find_duplicate_profiles profile
    duplicate_profiles = []
    profiles = Profile.find_all_by_first_name_and_middle_name_and_last_name profile.first_name, profile.middle_name, profile.last_name
    profiles += Profile.find_all_by_first_name_and_last_name profile.first_name, profile.last_name
    profiles.each{|p| duplicate_profiles << p unless duplicate_profiles.include?(p)}
    duplicate_profiles.delete(duplicate_profiles.first)
    duplicate_profiles
  end
  
  def per_page
    25
  end
  
  def searchable_class
    Profile
  end
  
  def perform_query klass, query
    query.gsub! '*', ''
    results = []
    klass.find_by_solr(query, :limit => :all).docs.each{|p| results << p.survivor unless p.survivor.nil?}
    results
  end
  
  def extract_survivors profiles
    survivors = []
    profiles.collect {|p| survivors << p.survivor if p.survivor}
    survivors
  end
end