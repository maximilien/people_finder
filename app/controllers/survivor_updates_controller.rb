# 
# Controller for the SurvivorUpdate model
# @author E. M. Maximilien
# Copyright (C) IBM Corp., 2011
# License under the MIT license, found here: http://goo.gl/s9uhf
#

require 'pp'

class SurvivorUpdatesController < ApplicationController
  include SearchableHelper 
  
  before_filter :set_survivor_updates_tab, :reminders
  
  before_filter :'only_superusers?', :only => [:tweet]
  
  def randomly_tweet
    @number = params[:number].to_i || 5
    @survivor_updates = SurvivorUpdate.non_tweeted
    @max_tweet = generate_random_tweets @survivor_updates, @number
    flash[:notice] = "Generated #{@max_tweet} survivor update tweets"
    redirect_to :action => 'index'
  end
  
  def tweet
    @survivor_update = SurvivorUpdate.find params[:id]
    @survivor_update.tweet
    redirect_to :action => 'index'
  end
  
  def remove
    @survivor_update = SurvivorUpdate.find params[:id]
    @survivor_update.survivor.destroy if  @survivor_update.survivor.survivor_updates.size == 1
    @survivor_update.destroy
    redirect_to :action => 'index'
  end
  
  # GET /survivor_updates
  # GET /survivor_updates.xml
  def index
    order = params[:order] || 'updated_at DESC'
    @all_survivor_updates = SurvivorUpdate.paginate :page => params[:page], 
                                                    :per_page => per_page, 
                                                    :order => order
    @missing_survivor_updates = SurvivorUpdate.paginate :page => params[:page], 
                                               :per_page => per_page, 
                                               :order => order, 
                                               :conditions => ['status = ?',
                                                  SurvivorUpdate::MISSING],
                                               :include => [:survivor, :user]
    @ok_survivor_updates = SurvivorUpdate.paginate :page => params[:page], 
                                                   :per_page => per_page, 
                                                   :order => order, 
                          :conditions => ['status = ? OR status = ?', 
                                          SurvivorUpdate::OK, SurvivorUpdate::WELL],
                          :include => [:survivor, :user]
    @injured_survivor_updates = SurvivorUpdate.paginate :page => params[:page], 
                                                        :per_page => per_page, 
                                                        :order => order, 
                            :conditions => ['status = ?', SurvivorUpdate::INJURED],
                            :include => [:survivor, :user]
    @other_survivor_updates = SurvivorUpdate.paginate :page => params[:page],
                                                      :per_page => per_page, 
                                                      :order => order, 
                              :conditions => ['status = ? OR status = ? OR status = ? OR status = ?', 
                                SurvivorUpdate::OTHER,
                                SurvivorUpdate::DECEASED_UNCONFIRMED,
                                SurvivorUpdate::DECEASED_CONFIRMED,
                                SurvivorUpdate::TRAPPED],
                              :include => [:survivor, :user]

    respond_to do |format|
      format.fbml # index.fbml.erb
      format.xml  { render :xml => @survivor_updates }
    end
  end
  
  # GET /survivor_updates/1
  # GET /survivor_updates/1.xml
  def show
    @survivor_update = SurvivorUpdate.find(params[:id])
    
    respond_to do |format|
      format.fbml # show.fbml.erb
      format.xml  { render :xml => @survivor_update }
    end
  end
  
  # GET /survivor_updates/new
  # GET /survivor_updates/new.xml
  def new
    @survivor = Survivor.find params[:survivor_id]
    @survivor_update = SurvivorUpdate.new
    @profile = @survivor.profile
    
    respond_to do |format|
      format.fbml
      format.xml  { render :xml => @survivor_update }
    end
  end
  
  # GET /survivor_updates/1/edit
  def edit
    @survivor_update = SurvivorUpdate.find(params[:id])
  end
  
  # POST /survivor_updates
  # POST /survivor_updates.xml
  def create
    @survivor_update = SurvivorUpdate.new(params[:survivor_update])
    @survivor = Survivor.find params[:survivor_update][:survivor_id]
    @survivor_update.user = current_user
    
    @survivor.last_status = @survivor_update.status
    @survivor.survivor_updates << @survivor_update
    respond_to do |format|
      if @survivor.save and @survivor_update.save
        @survivor_update.tweet unless @survivor_update.status == SurvivorUpdate::DECEASED_UNCONFIRMED
        begin
          NotificationPublisher.deliver_survivor_update_notification current_user, @survivor_update if current_user.profile.share_info_with_all?
        rescue
          logger.info "#{app_name}: error trying to invoke NotificationPublisher.deliver_survivor_update_notification"
        end
        flash[:notice] = "Update for survivor or victim #{@survivor.formatted_name} was successfully created."
        format.fbml { redirect_to :action => 'index' }
        format.xml  { render :xml => @survivor_update, :status => :created, :location => @survivor_update }
      else
        format.fbml { render :action => "new" }
        format.xml  { render :xml => @survivor_update.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /survivor_updates/1
  # PUT /survivor_updates/1.xml
  def update
    @survivor_update = SurvivorUpdate.find(params[:id])
    @survivor = @survivor_update.survivor
    
    @survivor.last_status = @survivor_update.status
    @survivor_update.update_attributes(params[:survivor_update])
    
    respond_to do |format|
      if @survivor_update.save and @survivor.save
        begin
          NotificationPublisher.deliver_survivor_update_notification current_user, @survivor_update if current_user.profile.share_info_with_all?
        rescue
          logger.info "#{app_name}: error trying to invoke NotificationPublisher.deliver_survivor_update_notification"
        end
        flash[:notice] = "Survivor or victim #{@survivor.formatted_name} status was successfully updated."
        format.fbml { redirect_to :action => 'index' }
        format.xml  { head :ok }
      else
        format.fbml { render :action => "edit" }
        format.xml  { render :xml => @survivor_update.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # DELETE /survivor_updates/1
  # DELETE /survivor_updates/1.xml
  def destroy
    @survivor_update = SurvivorUpdate.find(params[:id])
    @survivor_update.destroy
    
    respond_to do |format|
      format.fbml { redirect_to(survivor_updates_url) }
      format.xml  { head :ok }
    end
  end
  
  protected
  
  def searchable_class
    Profile
  end
  
  def perform_query klass, query
    query.gsub! '*', ''
    results = []
    klass.find_by_solr(query, :limit => :all).docs.each {|p| results += p.survivor.survivor_updates unless p.survivor.nil?}
    results
  end
end