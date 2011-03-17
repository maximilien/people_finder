# 
# Controller for Bulk upload and Admin features
# @author E. M. Maximilien
# Copyright (C) IBM Corp., 2011
# License under the MIT license, found here: 
# 

class Bulk
  attr_accessor :csv, :model_name, :data, :examples
  
  def xml
    !csv
  end
  
  def xml= b
    cvs = !b
  end
  
  def initialize hash={}
    hash.each_pair {|k,v| eval "@#{k.to_s} = v"}
    @examples = {}
  end
end

class AdminController < ApplicationController
  include AdminHelper
  include CsvParserHelper
  
  before_filter :set_admin_tab, :'only_superusers?'
  
  def index
    @stats = Stat.paginate :page => params[:page], :per_page => per_page,
                           :order => 'updated_at DESC'
    
    @users = User.paginate :page => params[:page], :per_page => per_page
    
    @locations = Location.paginate :page => params[:page], :per_page => per_page,
                                   :order => 'name ASC'
    
    @duplicate_locations = Location.paginate :page => params[:page], 
                                             :per_page => per_page,
                                             :conditions => ['duplicate = ?', true],
                                             :order => 'name ASC'
    
    @survivors = Survivor.paginate :page => params[:page], :per_page => per_page,
                                   :order => 'updated_at DESC'
    
    @duplicate_survivors = Survivor.paginate :page => params[:page], 
                                             :per_page => per_page,
                                             :conditions => ['duplicate = ?', true],
                                             :order => 'updated_at ASC'
    
    @survivor_updates = SurvivorUpdate.paginate :page => params[:page], 
                                                :per_page => per_page,
                                                :order => 'updated_at DESC'
  end
  
  def tweet_survivor
    @survivor = Survivor.find params[:id]
    @suvivor.tweet
    redirect_to :controller => 'admin', :action => 'index'
  end
  
  def bulk_add_locations
    @bulk = Bulk.new :model_name => 'Location', :csv => true, :data => ''
    @bulk.examples[:csv] = %{name, nickname, street1, street2, city, country, kind, web_site_url, picture_url, description}
  end
  
  def bulk_add_survivors
    @bulk = Bulk.new :model_name => 'Survivor', :csv => true, :data => ''
    @bulk.examples[:csv] = %{status, salutation, first_name, middle_name, last_name, suffix, nickname, citizen_of, mobile_phone, home_phone, work_phone, confirmed?, confirmation_source, description}
  end
  
  def bulk_add
    @csv = params[:bulk][:csv]
    @model_name = params[:bulk][:model_name]
    @data = params[:bulk][:data]
    
    @created, @modified, @messages = parse_and_create_bulk_csv_data @model_name, @data if @csv
    @created, @modified, @messages = parse_and_create_bulk_xml_data @model_name, @data if !@csv
    @timestamp = Time.now
  end
  
  def post_remove_callback
    current_user.profile.destroy unless current_user.profile.nil?
    assign_survivors_and_survivor_updates_to_default_admin_user current_user
    current_user.destroy unless current_user.nil?
  end
  
  private
  
  def set_admin_tab
    @admin_tab = 'AdminTab'
  end
  
  def assign_survivors_and_survivor_updates_to_default_admin_user user
    user.survivor_updates.each{|su| su.update_attributes :user_id => default_admin_user.id}
    user.survivors.each{|s| s.update_attributes :user_id => default_admin_user.id}
  end
  
  def parse_and_create_bulk_csv_data model_name, data
    created, modified, messages = [], [], []
    model_hashes = parse_models_from_csv model_name, data
    
    case model_name
    when 'Location' : created, modified, messages = create_locations model_hashes
model_hashes
    when 'Survivor' : created, modified, messages = create_survivors model_hashes
model_hashes
    end
    
    messages << "#{created.size} created and #{modified.size} modified #{model_name.pluralize} from CSV data"
    [created, modified, messages]
  end
  
  def create_models models_hashes, model_name, model_class, &find_or_create_model
    created, modified, messages = [], [], []
    models_hashes.each do |model_hash|
      model_hash[:user_id] = current_user.id
      message = ""
      model = yield model_hash, :find => true, :update => true
      if !model.nil?
        modified << model
        message += "Modified #{model_name.downcase}: '#{model.name}'"
      else
        model = yield model_hash, :create => true
        created << model
        message += "Created new #{model_name.downcase}: '#{model.name}'"
      end
      if model.save!
        message += " and succesfully saved it"
      else
        messages << "Could not save #{model_name.downcase}: '#{model.name}'"
      end
      messages << message
    end
    [created, modified, messages]
  end
  
  def create_locations locations_hashes
    create_models(locations_hashes, 'Location', Location) do |model_hash, opts|
      location = Location.find_by_name model_hash[:name] if opts[:find]
      location.update_attributes model_hash if opts[:update] and !location.nil?
      location = Location.create model_hash if opts[:create]
      location
    end
  end
  
  def create_survivors survivors_hashes
    create_models(survivors_hashes, 'Survivor', Survivor) do |model_hash, opts|
      survivor, profile, survivor_update, location = nil, nil, nil, nil
      if opts[:find] or opts[:update]
        profile = Profile.find_by_first_name_and_last_name model_hash[:first_name], model_hash[:last_name]
        survivor = profile.survivor unless profile.nil?
        location = survivor.location unless survivor.nil?
        survivor_update = survivor.survivor_updates.last unless survivor.nil?
        if opts[:update] and !survivor.nil?
          profile.update_attributes model_hash.reject{|k,v| [:status, :location, :confirmed, :confirmation_source, :user_id].include?(k)}
          location = Location.find_by_name hash[:location]
          survivor.location = location unless location.nil?
        end
      else
        survivor, profile, survivor_update, location = Survivor.create_from_hash model_hash
        survivor.update_attributes :last_status => survivor_update.status unless survivor.nil? or survivor_update.nil?
      end
      survivor
    end
  end
end