require 'uri'
require 'net/http'
require 'pfif_xml_parser_helper'

module PfifXmlHelper
  include PfifXmlParserHelper
  
  def parse_pfif xml_url_or_content
    xml_content = xml_url_or_content
    xml_content = get_xml_content xml_url_or_content
    PfifData.parse xml_content
  end
  
  private
  
  def get_xml_content xml_file_or_url
    if xml_file_or_url.include? 'http://'
      return get_xml_content_via_http xml_file_or_url
    elsif File.exist? xml_file_or_url
      return get_xml_content_via_file xml_file_or_url
    else
      return xml_file_or_url
    end
  end
  
  def get_xml_content_via_file xml_file
    File.open(xml_file, 'r').read
  end
  
  def get_xml_content_via_http xml_url
    url = URI.parse xml_url
    res = Net::HTTP.start(url.host, url.port) do |http|
      http.get url.path
    end
    res.body
  end
end