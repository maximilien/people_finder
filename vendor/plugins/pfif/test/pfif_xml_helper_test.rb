require 'test_helper'
require 'pfif_xml_helper'

class PfifXmlHelperTest < ActiveSupport::TestCase  
  include PfifXmlHelper
  
  test "parse PFIF XML file into data objects" do
    pfif_data = parse_pfif File.dirname(__FILE__) + '/examples/pfif_salesforce.xml'
    assert !pfif_data.nil?
    assert !pfif_data.persons.nil?
    assert !pfif_data.persons.size == 0
  end
end
