# 
# Helper module for Profile controller
# @author E. M. Maximilien
# Copyright (C) IBM Corp., 2011
# License under the MIT license, found here: http://goo.gl/s9uhf
#

module ProfilesHelper
  include ApplicationHelper

  const_set 'MR', 'Mr' unless defined? MR
  const_set 'MM', 'Mrs' unless defined? MM
  const_set 'MISS', 'Miss' unless defined? MISS
  const_set 'REV', 'Rev' unless defined? REV
  const_set 'DR', 'Dr' unless defined? DR
  const_set 'FRERES', 'Frères' unless defined? FRERES
  const_set 'PERE', 'Père' unless defined? PERE
  const_set 'MONSEIGNEUR', 'Monseigneur' unless defined? MONSEIGNEUR
  const_set 'SENATOR', 'Sénator' unless defined? SENATOR
  const_set 'MAJOR', 'Major' unless defined? MAJOR
  const_set 'CAPORAL', 'Caporal' unless defined? CAPORAL
  const_set 'GENERAL', 'Géneral' unless defined? GENERAL
  const_set 'OTHER', 'Other' unless defined? OTHER
  const_set 'SALUTATIONS', [MR, MM, MISS, REV, DR,
                            FRERES, PERE, MONSEIGNEUR, SENATOR, MAJOR, 
                            CAPORAL, GENERAL, OTHER] unless defined? SALUTATIONS
  
  const_set 'JR', 'Jr' unless defined? JR
  const_set 'II', 'II' unless defined? II
  const_set 'III', 'III' unless defined? III
  const_set 'IV', 'IV' unless defined? IV
  const_set 'SUFFIXES', [JR, II, III, IV] unless defined? SUFFIXES
end
