require File.dirname(__FILE__) + '/../test_helper'

class AlmamatersControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:almamaters)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_almamater
    assert_difference('Almamater.count') do
      post :create, :almamater => { }
    end

    assert_redirected_to almamater_path(assigns(:almamater))
  end

  def test_should_show_almamater
    get :show, :id => almamaters(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => almamaters(:one).id
    assert_response :success
  end

  def test_should_update_almamater
    put :update, :id => almamaters(:one).id, :almamater => { }
    assert_redirected_to almamater_path(assigns(:almamater))
  end

  def test_should_destroy_almamater
    assert_difference('Almamater.count', -1) do
      delete :destroy, :id => almamaters(:one).id
    end

    assert_redirected_to almamaters_path
  end
end
