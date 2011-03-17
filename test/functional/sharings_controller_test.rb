require File.dirname(__FILE__) + '/../test_helper'

class SharingsController < ApplicationController; def rescue_action(e) raise e; end; end

class SharingsControllerTest < ActionController::TestCase
  def setup
    @controller = SharingsController.new
    @request = ActionController::TestRequest.new
    @response = ActionController::TestResponse.new
  end
  
  def test_index
    # get :index
    # assert_response :success
  end  
end
