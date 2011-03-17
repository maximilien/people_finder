require File.dirname(__FILE__) + '/../test_helper'

class InvitationsController < ApplicationController; def rescue_action(e) raise e; end; end

class InvitationsControllerTest < ActionController::TestCase
  def setup
    @controller = InvitationsController.new
    @request = ActionController::TestRequest.new
    @response = ActionController::TestResponse.new
  end
  
  def test_create 
    facebook_post :create, :ids => ["1234"]
    assert_response :success
    assert_template 'create'
  end
  
  def test_new
    facebook_get :new 
    assert_response :success 
    assert_template 'new' 
  end
end
