require File.dirname(__FILE__) + '/../test_helper'

class MenteesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:mentees)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_mentee
    assert_difference('Mentee.count') do
      post :create, :mentee => { }
    end

    assert_redirected_to mentee_path(assigns(:mentee))
  end

  def test_should_show_mentee
    get :show, :id => mentees(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => mentees(:one).id
    assert_response :success
  end

  def test_should_update_mentee
    put :update, :id => mentees(:one).id, :mentee => { }
    assert_redirected_to mentee_path(assigns(:mentee))
  end

  def test_should_destroy_mentee
    assert_difference('Mentee.count', -1) do
      delete :destroy, :id => mentees(:one).id
    end

    assert_redirected_to mentees_path
  end
end
