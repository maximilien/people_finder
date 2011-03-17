# 
# Helper controller for FBML
# @author E. M. Maximilien
# Copyright (C) IBM Corp., 2011
# License under the MIT license, found here: http://goo.gl/s9uhf
#

class FbmlController < ApplicationController
  def survivor_board
    set_schools_tab
    @survivor = Survivor.find params[:id]
  end
  
  def survivor_comments
    set_survivors_tab
    @survivor = Survivor.find params[:id]
  end
  
  def survivor_update_comments
    set_survivor_updates_tab
    @survivor_update = SurvivorUpdate.find params[:id]
  end
end