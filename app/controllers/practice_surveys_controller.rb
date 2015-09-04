class PracticeSurveysController < ApplicationController
  before_action :set_practice_survey, only: [:show, :edit, :update, :destroy]

  # GET /practice_surveys
  # GET /practice_surveys.json
  def index
    @practice_surveys = PracticeSurvey.all
  end

  # GET /practice_surveys/1
  # GET /practice_surveys/1.json
  def show
  end

  # GET /practice_surveys/new
  def new
    @practice_survey = PracticeSurvey.new
  end

  # GET /practice_surveys/1/edit
  def edit
  end

  # POST /practice_surveys
  # POST /practice_surveys.json
  def create
    @practice_survey = PracticeSurvey.new(practice_survey_params)

    respond_to do |format|
      if @practice_survey.save
        format.html { redirect_to @practice_survey, notice: 'Practice survey was successfully created.' }
        format.json { render :show, status: :created, location: @practice_survey }
      else
        format.html { render :new }
        format.json { render json: @practice_survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /practice_surveys/1
  # PATCH/PUT /practice_surveys/1.json
  def update
    respond_to do |format|
      if @practice_survey.update(practice_survey_params)
        format.html { redirect_to @practice_survey, notice: 'Practice survey was successfully updated.' }
        format.json { render :show, status: :ok, location: @practice_survey }
      else
        format.html { render :edit }
        format.json { render json: @practice_survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /practice_surveys/1
  # DELETE /practice_surveys/1.json
  def destroy
    @practice_survey.destroy
    respond_to do |format|
      format.html { redirect_to practice_surveys_url, notice: 'Practice survey was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_practice_survey
      @practice_survey = PracticeSurvey.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def practice_survey_params
      params[:practice_survey]
    end
end
