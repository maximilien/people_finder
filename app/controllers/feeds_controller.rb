# 
# Controller for the Feed model
# @author E. M. Maximilien
# Copyright (C) IBM Corp., 2011
# License under the MIT license, found here: 
#


require 'date'
require 'icalendar'

class FeedsController < ApplicationController
  include FeedsHelper
  
  include Icalendar
  
  skip_before_filter :ensure_application_is_installed_by_facebook_user, :set_current_user, :update_stats, :reminders, :register_publish_action, :ensure_authenticated_to_facebook
  
  def friends
    @user = User.find params[:user_id]
    @friends = Friend.find :all, :order => 'updated_at DESC',
                           :conditions => ['user_id = ?', @user.id]
    
    respond_to do |format|
      format.atom  # friends.atom.builder
    end
  end
  
  def family_members
    @user = User.find params[:user_id]
    @family_members = FamilyMember.find :all, :order => 'updated_at DESC',
                                        :conditions => ['user_id = ?', @user.id]
    
    respond_to do |format|
      format.atom  # family_members.atom.builder
    end
  end
  
  def survivors
    @survivors = Survivor.find :all, :order => 'updated_at DESC'
    
    respond_to do |format|
      format.atom  # survivors.atom.builder
    end
  end
  
  def survivors_and_victims
    @survivors = Survivor.find :all, :order => 'updated_at DESC'
    
    respond_to do |format|
      format.atom  # survivors_and_victims.atom.builder
    end
  end
  
  def survivor_updates
    @status = params[:status]
    order = 'updated_at DESC'
    @missing_survivor_updates = SurvivorUpdate.paginate :page => params[:page], :per_page => per_page, :order => order, :conditions => ['status = ?', SurvivorUpdate::MISSING]
    @ok_survivor_updates = SurvivorUpdate.paginate :page => params[:page], :per_page => per_page, :order => order, :conditions => ['status = ? OR status = ?', SurvivorUpdate::OK, SurvivorUpdate::WELL]
    @injured_survivor_updates = SurvivorUpdate.paginate :page => params[:page], :per_page => per_page, :order => order, :conditions => ['status = ?', SurvivorUpdate::INJURED]
    @other_survivor_updates = SurvivorUpdate.paginate :page => params[:page], :per_page => per_page, :order => order, :conditions => ['status = ? OR status = ? OR status = ? OR status = ?', SurvivorUpdate::OTHER, SurvivorUpdate::DECEASED_UNCONFIRMED, SurvivorUpdate::DECEASED_CONFIRMED, SurvivorUpdate::TRAPPED]

    case @status.downcase
      when 'missing' : @survivor_updates = @missing_survivor_updates
      when 'ok' : @survivor_updates = @ok_survivor_updates
      when 'injured' : @survivor_updates = @injured_survivor_updates
      else @survivor_updates = @other_survivor_updates
    end

    respond_to do |format|
      format.atom  # survivor_updates.atom.builder
    end
  end
end