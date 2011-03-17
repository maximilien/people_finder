require File.dirname(__FILE__) + '/../test_helper'

class UserTest < ActiveSupport::TestCase
  fixtures :users, :profiles
  
  def setup
  end
  
  def test_attributes
    assert !@user_1.facebook_id.nil?
    assert !@user_1.session_key.nil?
    assert !@user_1.created_at.nil?
    assert !@user_1.updated_at.nil?
  end

  def test_associations
  end
end
