# 
# Helper module for the Twitter integration
# @author E. M. Maximilien
# Copyright (C) IBM Corp., 2011
# License under the MIT license, found here: 
#

module TwitterHelper
  def generate_random_tweets tweetable_models, number, max=5
    @number = number.to_i || max
    @max_tweet = rand(100).abs % @number 
    if tweetable_models.size <= @max_tweet
      tweetable_models.each {|m| m.tweet}
    else
      tweeted = 0
      while tweeted < @max_tweet
        tweetable_models.each do |s| 
          if (rand(@max_tweet).abs % 2) == 0
            s.tweet 
            tweeted += 1
          end
        end
      end
    end
    @max_tweet
  end
  
  def to_140 message, url, hashtags={}
    return '' if message.nil? or message.blank?
    return message if message.size >= 140
    return message[0..139] if message.size > 140
    msg140 = message
    msg140 += " #{url}" if (msg140.size + url.to_s.size + 1) < 140
    hashtags.values.each do |value|
      msg140 += " ##{value}" if (msg140.size + value.to_s.size + 2) < 140
    end
    msg140
  end
  
  def twitter_http_info
    TWITTER_HTTP_INFO
  end
  
  def twitter_http_auth
    Twitter::HTTPAuth.new twitter_http_info[:username], 
                          twitter_http_info[:password]
  end
  
  def twitter_oauth_info
    TWITTER_OAUTH_INFO
  end
  
  def twitter_oauth
    oauth = Twitter::OAuth.new twitter_oauth_info[:consumer_key],
                               twitter_oauth_info[:consumer_secret]
    oauth.authorize_from_access twitter_access_token(twitter_oauth_consumer),
                                twitter_access_secret(twitter_oauth_consumer)
    oauth
  end
  
  def twitter_request_token_token consumer=nil
    request_token = nil
    if consumer.nil?
      generate_twitter_request_token unless File.exist?(twitter_oauth_access_file)
      request_token =  YAML.load(File.open(twitter_oauth_access_file).read)[:request_token]
    else
      request_token = consumer.get_request_token.token
    end
    request_token
  end
  
  def twitter_request_token_secret consumer=nil
    request_token = nil
    if consumer.nil?
      generate_twitter_request_token unless File.exist?(twitter_oauth_access_file)
      request_token = YAML.load(File.open(twitter_oauth_access_file).read)[:request_secret]
    else
      request_token = consumer.get_request_token.secret
    end
    request_token
  end
  
  def oauth_request_token consumer
    OAuth::RequestToken.new consumer, twitter_request_token_token, 
                            twitter_request_token_secret
  end
  
  def twitter_access_token consumer
    oauth_request_token(consumer).get_access_token
  end
  
  def twitter_access_secret consumer
    oauth_request_token(consumer).get_access_secret
  end
  
  def twitter_oauth_consumer
    OAuth::Consumer.new twitter_oauth_info[:consumer_key],
                        twitter_oauth_info[:consumer_secret],
                        {:site => 'http://twitter.com'}
  end
  
  def twitter_oauth_access_file
    File.dirname(__FILE__) + '/../../' + TWITTER_OAUTH_YML
  end
  
  private
  
  def generate_twitter_request_token
    consumer = twitter_oauth_consumer
    request_token = consumer.get_request_token
    File.open(twitter_oauth_access_file, 'w') do |f| 
      f.write({:request_token => request_token.token, 
               :request_secret => request_token.secret}.to_yaml)
    end
  end
end