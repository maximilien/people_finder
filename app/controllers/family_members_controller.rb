class FamilyMembersController < ApplicationController
  include SearchableHelper
  
  before_filter :'only_superusers?', :only => [:remove, :destroy]
  
  def remove
    @family_member = FamilyMember.find params[:id]
    @family_member.destroy
    redirect_to :action => 'index'
  end
  
  # GET /family_members
  # GET /family_members.xml
  def index
    order = params[:order] || 'updated_at ASC'
    @family_members = FamilyMember.paginate :page => params[:page], 
                                            :per_page => per_page,
                                            :order => order,
                                            :include => [:profile, :user]
    
    respond_to do |format|
      format.fbml # index.fbml.erb
      format.xml  { render :xml => @family_members }
    end
  end
  
  # GET /family_members/1
  # GET /family_members/1.xml
  def show
    @family_member = FamilyMember.find(params[:id])
    
    respond_to do |format|
      format.fbml # show.fbml.erb
      format.xml  { render :xml => @family_member }
    end
  end
  
  # GET /family_members/new
  # GET /family_members/new.xml
  def new
    @family_member = FamilyMember.new
    
    respond_to do |format|
      format.fbml # new.fbml.erb
      format.xml  { render :xml => @family_member }
    end
  end
  
  # GET /family_members/1/edit
  def edit
    @family_member = FamilyMember.find(params[:id])
  end
  
  # POST /family_members
  # POST /family_members.xml
  def create
    @family_member = FamilyMember.new(params[:family_member])
    
    respond_to do |format|
      if @family_member.save
        flash[:notice] = 'FamilyMember was successfully created.'
        format.fbml { redirect_to(@family_member) }
        format.xml  { render :xml => @family_member, :status => :created, :family_member => @family_member }
      else
        format.fbml { render :action => "new" }
        format.xml  { render :xml => @family_member.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /family_members/1
  # PUT /family_members/1.xml
  def update
    @family_member = FamilyMember.find(params[:id])
    
    respond_to do |format|
      if @family_member.update_attributes(params[:family_member])
        flash[:notice] = 'FamilyMember was successfully updated.'
        format.fbml { redirect_to(@family_member) }
        format.xml  { head :ok }
      else
        format.fbml { render :action => "edit" }
        format.xml  { render :xml => @family_member.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # DELETE /family_members/1
  # DELETE /family_members/1.xml
  def destroy
    @family_member = FamilyMember.find(params[:id])
    @family_member.destroy
    
    respond_to do |format|
      format.fbml { redirect_to(family_members_url) }
      format.xml  { head :ok }
    end
  end
  
  protected
  
  def searchable_class
    FamilyMember
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