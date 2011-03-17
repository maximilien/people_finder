class ProfilesController < ApplicationController
  include FacebookApiHelper
  
  before_filter :'only_superusers?', :only => [:remove, :destroy]
  
  def remove
    @profile = Profile.find params[:id]
    @user = @profile.user
    @user.destroy
    @profile.destroy
    redirect_to :controller => 'admin', :action => 'index'
  end
  
  def get_data_from_facebook
    @profile = Profile.find(params[:id])
    @profile.update_attributes get_facebook_profile_info(current_user.facebook_session.user)
    
    @locations = Location.find :all, :order => 'name ASC'
    render :action => 'edit'
  end
  
  def add_user_expertise
    @profile = current_user.profile
    @expertise = Expertise.find params[:expertise_id]
    unless @profile.has_expertise?(@expertise)
      @user_expertise = UserExpertise.create :expertise_id => @expertise.id, 
                                           :profile_id => current_user.profile.id 
      @user_expertise.save
    end
    @user_expertise ||= UserExpertise.find_by_expertise_id_and_profile_id @expertise.id, @profile.id
  end
  
  # GET /profiles/1
  # GET /profiles/1.xml
  def show
    @profile = Profile.find(params[:id])
    if params[:commit] ==  "Update User Expertise"
      user_expertise = UserExpertise.find params[:user_expertise][:id]
      user_expertise.proficiency_level = params[:user_expertise][:proficiency_level]
      user_expertise.save
    elsif params[:commit] == 'Update'
      update
      return
    end
    
    respond_to do |format|
      format.fbml # show.fbml.erb
      format.xml  { render :xml => @profile }
    end
  end
  
  # GET /profiles/new
  # GET /profiles/new.xml
  def new
    new_profile
    all_locations
    
    respond_to do |format|
      format.fbml # new.fbml.erb
      format.xml  { render :xml => @profile }
    end
  end
  
  # GET /profiles/1/edit
  def edit
    @profile = Profile.find(params[:id])
    @profile.about_yourself = %{About you\r\n\nWhat can I offer?\r\n\nWho am I looking for?\r\n\r\n} if @profile.about_yourself.nil? or @profile.about_yourself.blank?
    all_locations
  end
  
  # POST /profiles
  # POST /profiles.xml
  def create
    @profile = Profile.new(params[:profile])
    
    respond_to do |format|
      if @profile.save
        create_mentor_mentee_for @profile
        @mentor.save unless @mentor.nil?; @mentee.save unless @mentee.nil?
        flash[:notice] = 'Profile was successfully created.'
        format.fbml { redirect_to :action => 'show', :id => @profile.id }
        format.xml  { render :xml => @profile, :status => :created, :location => @profile }
      else
        format.fbml do 
          new_profile; all_locations; render :action => "new" 
        end
        format.xml  { render :xml => @profile.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /profiles/1
  # PUT /profiles/1.xml
  def update
    @profile = Profile.find(params[:id])
    
    respond_to do |format|
      if @profile.update_attributes(params[:profile]) and @profile.save and @profile.user.save
        flash[:notice] = 'Profile was successfully updated.'
        format.fbml { redirect_to :controller => 'survivor_updates', :action => 'index' }
        format.xml  { head :ok }
      else
        format.fbml do 
          redirect_to :action => 'edit', :id => @profile.id 
        end
        format.xml  { render :xml => @profile.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # DELETE /profiles/1
  # DELETE /profiles/1.xml
  def destroy
    if current_user.superuser?
      @profile = Profile.find(params[:id])
      @profile.destroy
      respond_to do |format|
        format.fbml { redirect_to(profiles_url) }
        format.xml  { head :ok }
      end
    else
      flash[:notice] = 'You are not authorized to perform this action'
      format.fbml { redirect_to :controller => 'survivor_updates', :action => 'index' }      
    end
  end
  
  private
  
  def new_profile
    @profile = Profile.new :about_yourself => %{About you\r\n\nWhat can I offer?\r\n\nWhat am I looking for?\r\n\r\n}
  end
  
  def all_locations
    @locations = Location.find :all, :order => 'name ASC'
  end
end