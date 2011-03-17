# 
# Controller for the My updates, e.g., My friends, My family, etc.
# @author E. M. Maximilien
# Copyright (C) IBM Corp., 2011
# License under the MIT license, found here: 
#

class MyController < ApplicationController
  def family_members
    @family_members = FamilyMember.paginate :page => params[:page], 
                                             :per_page => per_page,
                                             :order => 'updated_at ASC',
                                             :conditions => ['user_id = ?', current_user.id]
  end
  
  def friends
    @friends = Friend.paginate :page => params[:page], 
                               :per_page => per_page,
                               :order => 'updated_at ASC',
                               :conditions => ['user_id = ?', current_user.id]
  end
  
  def survivors
    @survivors = Survivor.by_user current_user
  end
  
  def survivor_updates
    @survivor_updates = SurvivorUpdate.by_user current_user
  end
end