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
    @form_page = "form_page_1"
    @complete_percentage = 0
  end

  # GET /practice_surveys/1/edit
  def edit
    @form_page = "form_page_#{@practice_survey.last_page_saved + 1}"
    @complete_percentage = (@practice_survey.last_page_saved - 1)*10
  end

  # POST /practice_surveys
  # POST /practice_surveys.json
  def create
    @practice_survey = PracticeSurvey.new(practice_survey_params)
    @practice_survey.practice_id = @practice_survey.survey_key[3..8]

    respond_to do |format|
      if @practice_survey.save
        format.html { redirect_to edit_practice_survey_path(@practice_survey), notice: 'Practice survey was successfully created.' }
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
        if params['commit']
          format.html { redirect_to edit_practice_survey_path(@practice_survey), notice: 'Practice survey was successfully updated.' }
          format.json { render :show, status: :ok, location: @practice_survey }
        else
          @practice_survey.update_attribute('last_page_saved', @practice_survey.last_page_saved - 2)
          format.html { redirect_to edit_practice_survey_path(@practice_survey), notice: 'Practice survey was successfully updated.' }
          format.json { render :show, status: :ok, location: @practice_survey }
        end
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
      params[:practice_survey].permit(:survey_key, :last_page_saved, :name_survey_completer,
        :role_survey_completer,
        :pat_visits_week, :pat_panel, :pat_panel_sz, :prov_visits_day,
        :prac_race_white, :prac_race_black, :prac_race_aian, :prac_race_asian, :prac_race_pi,
        :prac_race_other, :prac_race_unk, :prac_race_nocoll, :prac_ethnicity_h,
        :prac_ethnicity_nh, :prac_ethnicity_unk, :prac_ethnicity_nocoll, :prac_pat_age_lt17,
        :prac_pat_age_18to39, :prac_pat_age_40to59, :prac_pat_age_60to75, :prac_pat_age_76andover,
        :prac_payor_medicare, :prac_payor_medicaid, :prac_payor_dual, :prac_payor_commercial,
        :prac_payor_noins, :prac_payor_other, :prac_payor_specify, :prac_under_ser)
    end
end
