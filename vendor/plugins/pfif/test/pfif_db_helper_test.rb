require 'test_helper'
require 'pfif_db_helper'

class PfifDbHelperTest < ActiveSupport::TestCase
  include PfifDbHelper
  
  test "get the PFIF domain root URL" do
    assert domain_root_url == 'pfif.org'
  end
    
  test "generate persons DB models from PFIF XML" do
    #TODO: complete me!
  end
end
