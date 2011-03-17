# 
# Controller for the Location model
# @author E. M. Maximilien
# Copyright (C) IBM Corp., 2011
# License under the MIT license, found here: http://goo.gl/s9uhf
#

class LocationsController < ApplicationController
  include LocationsHelper
  include SearchableHelper
  
  skip_before_filter :ensure_application_is_installed_by_facebook_user, :set_current_user, :update_stats, :reminders, :register_publish_action, :ensure_authenticated_to_facebook, :only => ['show_map', 'show_locations_map']
  
  before_filter :'only_superusers?', :only => [:remove, :destroy]
  before_filter :set_locations_tab
  
  def remove_duplicate
    @location = Location.find params[:id]
    @location.update_attributes :duplicate => false
    redirect_to :action => 'show'
  end
  
  def duplicate
    @location = Location.find params[:id]
    @location.update_attributes :duplicate => true
    redirect_to :action => 'show'
  end
  
  def show_locations
    @locations = Location.find :all
  end
  
  def show_locations_map
    @locations = Location.find :all
    render :template => 'locations/show_locations_map', :layout => false
  end
  
  def show_map
    @location = Location.find params[:id]
    render :template => 'locations/show_map', :layout => false
  end
  
  def map
    @location = Location.find params[:id]
  end
  
  def remove
    @location = Location.find params[:id]
    @location.survivors.each{|s| s.update_attributes :location_id => Location.default.id}
    @location.destroy unless @location == Location.default
    redirect_to :action => 'index'
  end
  
  def survivors
    @location = Location.find params[:id]
    @survivors = @location.survivors
  end

  # GET /locations
  # GET /locations.xml
  def index
    order = params[:order] || 'name ASC'
    @locations = Location.paginate :page => params[:page], :per_page => per_page,
                                   :order => order
    
    respond_to do |format|
      format.fbml # index.fbml.erb
      format.xml  { render :xml => @locations }
    end
  end
  
  # GET /locations/1
  # GET /locations/1.xml
  def show
    @location = Location.find(params[:id])
    
    respond_to do |format|
      format.fbml # show.fbml.erb
      format.xml  { render :xml => @location }
    end
  end
  
  # GET /locations/new
  # GET /locations/new.xml
  def new
    @location = Location.new
    
    respond_to do |format|
      format.fbml # new.fbml.erb
      format.xml  { render :xml => @location }
    end
  end
  
  # GET /locations/1/edit
  def edit
    @location = Location.find(params[:id])
  end
  
  # POST /locations
  # POST /locations.xml
  def create
    @location = Location.new(params[:location])
    
    respond_to do |format|
      if @location.save
        flash[:notice] = 'Location was successfully created.'
        format.fbml { redirect_to(@location) }
        format.xml  { render :xml => @location, :status => :created, :location => @location }
      else
        format.fbml { render :action => "new" }
        format.xml  { render :xml => @location.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /locations/1
  # PUT /locations/1.xml
  def update
    @location = Location.find(params[:id])
    
    respond_to do |format|
      if @location.update_attributes(params[:location])
        flash[:notice] = 'Location was successfully updated.'
        format.fbml { redirect_to(@location) }
        format.xml  { head :ok }
      else
        format.fbml { render :action => "edit" }
        format.xml  { render :xml => @location.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # DELETE /locations/1
  # DELETE /locations/1.xml
  def destroy
    @location = Location.find(params[:id])
    @location.destroy
    
    respond_to do |format|
      format.fbml { redirect_to(locations_url) }
      format.xml  { head :ok }
    end
  end
  
  protected
  
  def per_page
    15
  end
  
  def searchable_class
    Location
  end
  
  def perform_query klass, query
    query.gsub! '*', ''
    return klass.find_by_solr(query, :limit => :all).docs
  end
end