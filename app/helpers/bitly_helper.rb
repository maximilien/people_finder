# 
# Helper module for Bitly integration
# @author E. M. Maximilien
# Copyright (C) IBM Corp., 2011
# License under the MIT license, found here: http://goo.gl/s9uhf
#

# TODO: fix rack issue
#require 'bitly'

module BitlyHelper
  def bitly_info
    BITLY_INFO
  end
  
  def bitly_shorten url
    bitly = Bitly.new bitly_info[:login], bitly_info[:api_key]
    bitly.shorten(url).short_url
  end
end