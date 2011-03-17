require File.dirname(__FILE__) + '/../test_helper'

class ExpertiseKindsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:expertise_kinds)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_expertise_kind
    assert_difference('ExpertiseKind.count') do
      post :create, :expertise_kind => { }
    end

    assert_redirected_to expertise_kind_path(assigns(:expertise_kind))
  end

  def test_should_show_expertise_kind
    get :show, :id => expertise_kinds(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => expertise_kinds(:one).id
    assert_response :success
  end

  def test_should_update_expertise_kind
    put :update, :id => expertise_kinds(:one).id, :expertise_kind => { }
    assert_redirected_to expertise_kind_path(assigns(:expertise_kind))
  end

  def test_should_destroy_expertise_kind
    assert_difference('ExpertiseKind.count', -1) do
      delete :destroy, :id => expertise_kinds(:one).id
    end

    assert_redirected_to expertise_kinds_path
  end
end
