require File.dirname(__FILE__) + '/../test_helper'

class SharingTest < ActiveSupport::TestCase
  fixtures :users, :sharings, :mentoring_sessions
  
  def test_attributes
    assert @sharing_1.user_id == 1
    assert @sharing_1.shared_user_id == 2
    assert @sharing_1.mentoring_session_id == 1
    assert !@sharing_1.created_at.nil?
    assert !@sharing_1.updated_at.nil?
  end
  
  def test_associations
    #User.belongs_to :user
    assert @sharing_1.user.id == @user_1.id
    
    #User.belongs_to :shared_user
    assert @sharing_1.shared_user.id == @user_2.id
    
    #User.belongs_to :mentoring_session
    assert @sharing_1.mentoring_session.id == @mentoring_session_1.id
  end
end
