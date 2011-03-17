require File.dirname(__FILE__) + '/../test_helper'

class WelcomeController < ApplicationController; def rescue_action(e) raise e; end; end

class WelcomeControllerTest < ActionController::TestCase
  def setup
    @controller = WelcomeController.new
    @request = ActionController::TestRequest.new
    @response = ActionController::TestResponse.new
  end
  
  def test_index
    facebook_get :index 
    assert_response :success 
    assert_template 'index'
  end  
  
  def test_about
    facebook_get :about 
    assert_response :success 
    assert_template 'about'
  end
  
  def test_tou
    facebook_get :tou
    assert_response :success 
    assert_template 'tou'
  end
end
