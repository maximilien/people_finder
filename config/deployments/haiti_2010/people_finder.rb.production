# 
# Sets up globally accessible configuration for the application
# @author E. M. Maximilien
# Copyright (C) IBM Corp., 2011
# License under the MIT license, found here: http://goo.gl/s9uhf
#

require 'yaml'

CREDENTIALS = Yaml.load_file File.dirname(__FILE__) + '/credentials.yml' unless defined? CREDENTIALS

APP_NAME = 'Haiti Quake Survivors' unless defined? APP_NAME
BITLY_URL = 'http://bit.ly/72C8V3' unless defined? BITLY_URL
VERSION_STRING = '1.1.1' unless defined? VERSION_STRING
CANVAS_NAME = 'haiti_survivors' unless defined? CANVAS_NAME

DEFAULT_HOSTNAME_STRING = '174.129.134.98' unless defined? DEFAULT_HOSTNAME_STRING
DEFAULT_PORT_STRING = '5000' unless defined? DEFAULT_PORT_STRING

TWITTER_OAUTH_INFO = {:consumer_key => CREDENTIALS['production']['twitter']['consumer_key'],
                      :consumer_secret => CREDENTIALS['production']['twitter']['consumer_secret'],
                      :request_token_url => 'http://twitter.com/oauth/request_token',
                      :access_token_url => 'http://twitter.com/oauth/access_token',
                      :authorize_url => 'http://twitter.com/oauth/authorize'} unless defined? TWITTER_OAUTH_INFO

TWITTER_HTTP_INFO = {:username => CREDENTIALS['production']['twitter']['username'], 
                     :password => CREDENTIALS['production']['twitter']['password']} unless defined? TWITTER_HTTP_INFO

TWITTER_OAUTH_YML = 'lib/twitter/oauth.dev.yml' unless defined? TWITTER_OAUTH_YML

BITLY_INFO = {:login => CREDENTIALS['production']['bitly']['login'], 
              :api_key => CREDENTIALS['production']['twitter']['api_key']} unless defined? BITLY_INFO

GOOGLE_MAPS_API_KEY = CREDENTIALS['production']['google_maps']['api_key'] unless defined? GOOGLE_MAPS_API_KEY

GOOGLE_DB_AUTH_KEY = CREDENTIALS['production']['google_db']['auth_key'] unless defined? GOOGLE_DB_AUTH_KEY

DISABLE_TWITTER = true unless defined? DISABLE_TWITTER