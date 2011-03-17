require 'uri'
require 'net/http'

module GoogleCrisisResponseHelper
  # TODO: uncomment
  # include PfifXmlHelper
  # include PfifDbHelper
  
  def domain_root_url
    "haiti-survivors.org"
  end
  
  def api_url
    "http://haiticrisis.appspot.com/api"
  end
  
  def auth_key
    GOOGLE_DB_AUTH_KEY
  end
  
  def read_person_pfif person_record_id
    url = "#{api_url}/read?id=#{person_record_id}"
    xml = get_xml_content_via_http url
    
  end
  
  def write_persons_pfif persons
    #TODO: complete
  end
  
  protected
  
  def get_xml_content_via_http xml_url
    url = URI.parse xml_url
    res = Net::HTTP.start(url.host, url.port) do |http|
      http.get url.path
    end
    res.body
  end
  
  def post_xml_content_via_http xml, url
  end
end