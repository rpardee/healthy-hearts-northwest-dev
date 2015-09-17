require 'test_helper'

class IvcontactsControllerTest < ActionController::TestCase
  setup do
    @ivcontact = ivcontacts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ivcontacts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ivcontact" do
    assert_difference('Ivcontact.count') do
      post :create, ivcontact: {  }
    end

    assert_redirected_to ivcontact_path(assigns(:ivcontact))
  end

  test "should show ivcontact" do
    get :show, id: @ivcontact
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ivcontact
    assert_response :success
  end

  test "should update ivcontact" do
    patch :update, id: @ivcontact, ivcontact: {  }
    assert_redirected_to ivcontact_path(assigns(:ivcontact))
  end

  test "should destroy ivcontact" do
    assert_difference('Ivcontact.count', -1) do
      delete :destroy, id: @ivcontact
    end

    assert_redirected_to ivcontacts_path
  end
end
