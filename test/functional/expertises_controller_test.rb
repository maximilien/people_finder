require File.dirname(__FILE__) + '/../test_helper'

class ExpertisesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:expertises)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_expertise
    assert_difference('Expertise.count') do
      post :create, :expertise => { }
    end

    assert_redirected_to expertise_path(assigns(:expertise))
  end

  def test_should_show_expertise
    get :show, :id => expertises(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => expertises(:one).id
    assert_response :success
  end

  def test_should_update_expertise
    put :update, :id => expertises(:one).id, :expertise => { }
    assert_redirected_to expertise_path(assigns(:expertise))
  end

  def test_should_destroy_expertise
    assert_difference('Expertise.count', -1) do
      delete :destroy, :id => expertises(:one).id
    end

    assert_redirected_to expertises_path
  end
end
