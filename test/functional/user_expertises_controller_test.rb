require File.dirname(__FILE__) + '/../test_helper'

class UserExpertisesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:user_expertises)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_user_expertise
    assert_difference('UserExpertise.count') do
      post :create, :user_expertise => { }
    end

    assert_redirected_to user_expertise_path(assigns(:user_expertise))
  end

  def test_should_show_user_expertise
    get :show, :id => user_expertises(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => user_expertises(:one).id
    assert_response :success
  end

  def test_should_update_user_expertise
    put :update, :id => user_expertises(:one).id, :user_expertise => { }
    assert_redirected_to user_expertise_path(assigns(:user_expertise))
  end

  def test_should_destroy_user_expertise
    assert_difference('UserExpertise.count', -1) do
      delete :destroy, :id => user_expertises(:one).id
    end

    assert_redirected_to user_expertises_path
  end
end
