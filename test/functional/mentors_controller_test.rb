require File.dirname(__FILE__) + '/../test_helper'

class MentorsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:mentors)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_mentor
    assert_difference('Mentor.count') do
      post :create, :mentor => { }
    end

    assert_redirected_to mentor_path(assigns(:mentor))
  end

  def test_should_show_mentor
    get :show, :id => survivors(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => survivors(:one).id
    assert_response :success
  end

  def test_should_update_mentor
    put :update, :id => survivors(:one).id, :mentor => { }
    assert_redirected_to mentor_path(assigns(:mentor))
  end

  def test_should_destroy_mentor
    assert_difference('Mentor.count', -1) do
      delete :destroy, :id => survivors(:one).id
    end

    assert_redirected_to mentors_path
  end
end
