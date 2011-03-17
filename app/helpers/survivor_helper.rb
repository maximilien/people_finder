# 
# Helper module for the Survivor model
# @author E. M. Maximilien
# Copyright (C) IBM Corp., 2011
# License under the MIT license, found here: 
#

module SurvivorHelper
  const_set 'MISSING', 'Missing' unless defined? MISSING
  const_set 'WELL', 'Well' unless defined? WELL
  const_set 'OK', 'OK' unless defined? OK
  const_set 'TRAPPED', 'Trapped' unless defined? TRAPPED
  const_set 'INJURED', 'Injured' unless defined? INJURED
  const_set 'DECEASED_UNCONFIRMED', 'Deceased (unconfirmed)' unless defined? DECEASED_UNCONFIRMED
  const_set 'DECEASED_CONFIRMED', 'Deceased (confirmed)' unless defined? DECEASED_CONFIRMED
  const_set 'STATUSES', [MISSING, WELL, OK, TRAPPED, INJURED, DECEASED_UNCONFIRMED, DECEASED_CONFIRMED] unless defined? YEARS_WORKING
end