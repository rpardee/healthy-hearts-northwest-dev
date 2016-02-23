require 'test_helper'

class ManagerNotesControllerTest < ActionController::TestCase
  setup do
    @manager_note = manager_notes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:manager_notes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create manager_note" do
    assert_difference('ManagerNote.count') do
      post :create, manager_note: {  }
    end

    assert_redirected_to manager_note_path(assigns(:manager_note))
  end

  test "should show manager_note" do
    get :show, id: @manager_note
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @manager_note
    assert_response :success
  end

  test "should update manager_note" do
    patch :update, id: @manager_note, manager_note: {  }
    assert_redirected_to manager_note_path(assigns(:manager_note))
  end

  test "should destroy manager_note" do
    assert_difference('ManagerNote.count', -1) do
      delete :destroy, id: @manager_note
    end

    assert_redirected_to manager_notes_path
  end
end
