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