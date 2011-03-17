# 
# Friend model
# @author E. M. Maximilien
# Copyright (C) IBM Corp., 2011
# License under the MIT license, found here: http://goo.gl/s9uhf
#

class Friend < ActiveRecord::Base
  const_set 'FRIEND', 'Friend' unless defined? FRIEND
  const_set 'GOOD_FRIEND', 'Good friend' unless defined? GOOD_FRIEND
  const_set 'BEST_FRIEND', 'Best friend' unless defined? BEST_FRIEND
  const_set 'CHILDHOOD_FRIEND', 'Childhood friend' unless defined? CHILDHOOD_FRIEND
  const_set 'SCHOOL_FRIEND', 'School friend' unless defined? SCHOOL_FRIEND
  const_set 'ACQUAINTANCE', 'Acquaintance' unless defined? ACQUAINTANCE
  const_set 'OTHER', 'Other' unless defined? OTHER

  const_set 'LEVELS', [FRIEND, GOOD_FRIEND, BEST_FRIEND, CHILDHOOD_FRIEND,
                       SCHOOL_FRIEND, ACQUAINTANCE, OTHER] unless defined? LEVELS

  belongs_to :user
  belongs_to :survivor

  acts_as_solr :fields => [:name, :level, :description]
end