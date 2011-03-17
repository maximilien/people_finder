# 
# Controller for the Stats model
# @author E. M. Maximilien
# Copyright (C) IBM Corp., 2011
# License under the MIT license, found here: 
#

class StatsController < ApplicationController
  before_filter :'only_superusers?'
  
  def remove
    stat = Stat.find params[:id]
    stat.destroy unless stat.nil?
    redirect_to :controller => 'admin', :action => 'index'
  end
  
  def generate_csv_stats
    stats = Stat.find :all
    csv = %{Date,Users,Locations,Survivors,Updates\n}
    stats.each {|stat| csv += "#{stat.to_csv}\n"}
    save_csv_stats csv
    redirect_to :controller => 'admin', :action => 'index'
  end
  
  private
  
  def save_csv_stats csv
    File.open("#{RAILS_ROOT}/public/stats.csv", "w") {|file| file.write csv}
  end
end