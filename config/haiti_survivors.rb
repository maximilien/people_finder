# 
# Sets up globally accessible configuration for the application (Production)
# @author E. M. Maximilien
# Copyright (C) IBM Corp., 2011
# License under the MIT license, found here: http://goo.gl/s9uhf
#

VERSION_STRING = '1.1.1' unless defined? VERSION_STRING
CANVAS_NAME = 'haiti_survivors' unless defined? CANVAS_NAME

DEFAULT_HOSTNAME_STRING = '174.129.134.98' unless defined? DEFAULT_HOSTNAME_STRING
DEFAULT_PORT_STRING = '5000' unless defined? DEFAULT_PORT_STRING

TWITTER_OAUTH_INFO = {:consumer_key => 'AwTVTDbHNjtNQMhWbssTGA',
                      :consumer_secret => 'M42TmestDYvG4gzoIyT3Q0BnSfus7b91y952bpOP1g',
                      :request_token_url => 'http://twitter.com/oauth/request_token',
                      :access_token_url => 'http://twitter.com/oauth/access_token',
                      :authorize_url => 'http://twitter.com/oauth/authorize'} unless defined? TWITTER_OAUTH_INFO

TWITTER_HTTP_INFO = {:username => 'haiti_survivors', 
                     :password => 'q2waq2w'} unless defined? TWITTER_HTTP_INFO

TWITTER_OAUTH_YML = 'lib/twitter/oauth.golden.yml' unless defined? TWITTER_OAUTH_YML

BITLY_INFO = {:login => 'maximilien', 
              :api_key => "R_6a00768ccaa4d269c3ddc696d40aaab5"} unless defined? BITLY_INFO

GOOGLE_MAPS_API_KEY = "ABQIAAAAzMfwlvGeznuDF7Pn7i9VexQsZM35PIfPOaEqiBAxE_i1N5chlxRAHMdyWDa2xLRTLa_I5Vk_wFV67g" unless defined? GOOGLE_MAPS_API_KEY

GOOGLE_DB_AUTH_KEY = "PwbIjpVS5BpXWBut" unless defined? GOOGLE_DB_AUTH_KEY

DISABLE_TWITTER = false unless defined? DISABLE_TWITTER