require 'test_helper'

class CoachItemsControllerTest < ActionController::TestCase
  setup do
    @coach_item = coach_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:coach_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create coach_item" do
    assert_difference('CoachItem.count') do
      post :create, coach_item: {  }
    end

    assert_redirected_to coach_item_path(assigns(:coach_item))
  end

  test "should show coach_item" do
    get :show, id: @coach_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @coach_item
    assert_response :success
  end

  test "should update coach_item" do
    patch :update, id: @coach_item, coach_item: {  }
    assert_redirected_to coach_item_path(assigns(:coach_item))
  end

  test "should destroy coach_item" do
    assert_difference('CoachItem.count', -1) do
      delete :destroy, id: @coach_item
    end

    assert_redirected_to coach_items_path
  end
end
