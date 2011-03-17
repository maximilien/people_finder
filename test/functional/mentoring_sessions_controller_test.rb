require File.dirname(__FILE__) + '/../test_helper'

class MentoringSessionsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:mentoring_sessions)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_mentoring_session
    assert_difference('MentoringSession.count') do
      post :create, :mentoring_session => { }
    end

    assert_redirected_to mentoring_session_path(assigns(:mentoring_session))
  end

  def test_should_show_mentoring_session
    get :show, :id => mentoring_sessions(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => mentoring_sessions(:one).id
    assert_response :success
  end

  def test_should_update_mentoring_session
    put :update, :id => mentoring_sessions(:one).id, :mentoring_session => { }
    assert_redirected_to mentoring_session_path(assigns(:mentoring_session))
  end

  def test_should_destroy_mentoring_session
    assert_difference('MentoringSession.count', -1) do
      delete :destroy, :id => mentoring_sessions(:one).id
    end

    assert_redirected_to mentoring_sessions_path
  end
end
