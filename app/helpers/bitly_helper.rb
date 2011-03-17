require 'bitly'

module BitlyHelper
  def bitly_info
    BITLY_INFO
  end
  
  def bitly_shorten url
    bitly = Bitly.new bitly_info[:login], bitly_info[:api_key]
    bitly.shorten(url).short_url
  end
end