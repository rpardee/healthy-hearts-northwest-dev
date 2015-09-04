require 'test_helper'

class PracticeSurveysControllerTest < ActionController::TestCase
  setup do
    @practice_survey = practice_surveys(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:practice_surveys)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create practice_survey" do
    assert_difference('PracticeSurvey.count') do
      post :create, practice_survey: {  }
    end

    assert_redirected_to practice_survey_path(assigns(:practice_survey))
  end

  test "should show practice_survey" do
    get :show, id: @practice_survey
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @practice_survey
    assert_response :success
  end

  test "should update practice_survey" do
    patch :update, id: @practice_survey, practice_survey: {  }
    assert_redirected_to practice_survey_path(assigns(:practice_survey))
  end

  test "should destroy practice_survey" do
    assert_difference('PracticeSurvey.count', -1) do
      delete :destroy, id: @practice_survey
    end

    assert_redirected_to practice_surveys_path
  end
end
