# 
# Controller for the Friends model
# @author E. M. Maximilien
# Copyright (C) IBM Corp., 2011
# License under the MIT license, found here: 
#

class FriendsController < ApplicationController
  include SearchableHelper
  
  before_filter :'only_superusers?', :only => [:remove, :destroy]
  
  def remove
    @friend = Friend.find params[:id]
    @friend.destroy
    redirect_to :action => 'index'
  end
  
  # GET /friends
  # GET /friends.xml
  def index
    order = params[:order] || 'updated_at ASC'
    @friends = Friend.paginate :page => params[:page], 
                                            :per_page => per_page,
                                            :order => order,
                                            :include => [:profile, :user]
    
    respond_to do |format|
      format.fbml # index.fbml.erb
      format.xml  { render :xml => @friends }
    end
  end
  
  # GET /friends/1
  # GET /friends/1.xml
  def show
    @friend = Friend.find(params[:id])
    
    respond_to do |format|
      format.fbml # show.fbml.erb
      format.xml  { render :xml => @friend }
    end
  end
  
  # GET /friends/new
  # GET /friends/new.xml
  def new
    @friend = Friend.new
    
    respond_to do |format|
      format.fbml # new.fbml.erb
      format.xml  { render :xml => @friend }
    end
  end
  
  # GET /friends/1/edit
  def edit
    @friend = Friend.find(params[:id])
  end
  
  # POST /friends
  # POST /friends.xml
  def create
    @friend = Friend.new(params[:friend])
    
    respond_to do |format|
      if @friend.save
        flash[:notice] = 'Friend was successfully created.'
        format.fbml { redirect_to(@friend) }
        format.xml  { render :xml => @friend, :status => :created, :friend => @friend }
      else
        format.fbml { render :action => "new" }
        format.xml  { render :xml => @friend.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /friends/1
  # PUT /friends/1.xml
  def update
    @friend = Friend.find(params[:id])
    
    respond_to do |format|
      if @friend.update_attributes(params[:friend])
        flash[:notice] = 'Friend was successfully updated.'
        format.fbml { redirect_to(@friend) }
        format.xml  { head :ok }
      else
        format.fbml { render :action => "edit" }
        format.xml  { render :xml => @friend.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # DELETE /friends/1
  # DELETE /friends/1.xml
  def destroy
    @friend = Friend.find(params[:id])
    @friend.destroy
    
    respond_to do |format|
      format.fbml { redirect_to(friends_url) }
      format.xml  { head :ok }
    end
  end
  
  protected
  
  def searchable_class
    Friend
  end
  
  def perform_query klass, query
    state = params[:search][:state]
    if state.nil? or state.blank?
      return klass.find_by_solr(query, :limit => :all).docs
    else
      query.gsub! '*', ''
      return klass.find_by_solr(query, :limit => :all).docs
    end
  end
end