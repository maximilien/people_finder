# 
# Location model
# @author E. M. Maximilien
# Copyright (C) IBM Corp., 2011
# License under the MIT license, found here: http://goo.gl/s9uhf
#

class Location < ActiveRecord::Base
  include ApplicationHelper
  
  const_set 'REGION', 'Region' unless defined? REGION
  const_set 'CITY', 'City' unless defined? CITY
  const_set 'VILLAGE', 'Village' unless defined? VILLAGE
  const_set 'PROVINCE', 'Province' unless defined? PROVINCE
  const_set 'ISLAND', 'Island' unless defined? ISLAND
  const_set 'OTHER', 'Other' unless defined? OTHER
  const_set 'KINDS', [REGION, CITY, VILLAGE, PROVINCE, ISLAND, OTHER] unless defined? KINDS
  
  belongs_to :user
  
  has_many :survivors
  
  acts_as_solr :fields => [:name, :nickname, :kind, :street1, :street2, 
                           :description, :city, :country]

  def more_details
    %{#{(self.name.nil? or self.name.blank?) ? '' : self.name}<br/>Number of collected survivors or victims: <b>#{self.survivors.size}</b><br/>Missing: <b>#{self.missing.size}</b>, trapped: <b>#{self.trapped.size}</b>,OK & Well: <b>#{self.ok_well.size}</b>, and others: <b>#{self.other.size}</b>}
  end
  
  def details
    %{<b>#{(self.name.nil? or self.name.blank?) ? '' : self.name}</b><br/>Number of collected survivors or victims</a>: <b>#{self.survivors.size}</b>}
  end
  
  def address
    "#{(self.street1.nil? or self.street1.blank?) ? '' : self.street1 + ', '} #{self.city}, #{self.country}"
  end
  
  def missing
    Survivor.find :all, :conditions => ['location_id = ? AND last_status = ?', 
                                        self.id, Survivor::MISSING]
  end  
  
  def trapped
    Survivor.find :all, :conditions => ['location_id = ? AND last_status = ?', 
                                        self.id, Survivor::TRAPPED]
  end  
  
  def ok_well
    conditions_string = 'location_id = ? AND (last_status = ? OR last_status = ?)'
    Survivor.find :all, 
                  :conditions => [conditions_string, self.id, 
                                  Survivor::OK, Survivor::WELL]
  end
  
  def other
    conditions_string = 'location_id = ? AND (last_status = ? OR last_status = ? OR last_status = ?)'
    Survivor.find :all, 
                  :conditions => [conditions_string, self.id, 
                                  Survivor::INJURED, Survivor::DECEASED_CONFIRMED,
                                  Survivor::DECEASED_UNCONFIRMED]
  end
  
  def survivors
    Survivor.find :all, :conditions => ['location_id = ?', self.id]
  end
  
  def self.default
    Location.find_by_name('No Location') || Location.find_by_name("Default - Port-au-Prince")
  end
end