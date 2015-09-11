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
    # If survey_key is valid and exists in database, redirect to edit
    re_survey_key = /\w{2}\d{6}\w{2}/
    if re_survey_key.match(params[:survey_key])
      existing_survey = PracticeSurvey.where({ survey_key: params[:survey_key] })
      if existing_survey.exists?
        redirect_to edit_practice_survey_path(existing_survey.first)
      else
        @practice_survey = PracticeSurvey.new
        @form_page = "form_page_1"
        @complete_percentage = 0
      end
    else
      redirect_to root_path
    end
  end

  # GET /practice_surveys/1/edit
  def edit
    @form_page = "form_page_#{@practice_survey.last_page_saved + 1}"
    @complete_percentage = (((@practice_survey.last_page_saved)/14.to_f)*100).to_i
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
            Rails.logger.debug("Before update: #{@practice_survey.last_page_saved}")
      if @practice_survey.update(practice_survey_params)
            Rails.logger.debug("After update: #{@practice_survey.last_page_saved}")
        if params['commit']
            Rails.logger.debug("After commit param: #{@practice_survey.last_page_saved}")
          if @practice_survey.last_page_saved == PracticeSurvey::MAX_SURVEY_PAGES
            Rails.logger.debug("HIT LAST PAGE")
            Rails.logger.debug("Last Page Saved: #{@practice_survey.last_page_saved}")
            Rails.logger.debug("Max Survey Pages: #{PracticeSurvey::MAX_SURVEY_PAGES}")
            Rails.logger.debug("Hit last page")
            redirect_location = practice_survey_thanks_path
          else
            redirect_location = edit_practice_survey_path(@practice_survey)
          end
          format.html { redirect_to redirect_location, notice: 'Practice survey was successfully updated.' }
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
        :prac_payor_noins, :prac_payor_other, :prac_payor_specify, :prac_under_ser,
        :cpcq_strat_info_skills, :cpcq_strat_oplead_rolemdl, :cpcq_strat_sys_change,
        :cpcq_strat_red_barr, :cpcq_org_teams, :cpcq_use_nonclinician, :cpcq_authorize,
        :cpcq_periodic_measurement, :cpcq_reporting_measurement, :cpcq_goals, :cpcq_customize,
        :cpcq_rapid_cycles, :cpcq_design_care_clinician, :cpcq_design_care_process,
        :cpcq_priority, :cqm_ivd, :cqm_bp, :cqm_statin, :cqm_smokcess, :prac_cqm_prac,
        :prac_cqm_prov, :prac_ehr_labs, :prac_ehr_race_doc, :prac_ehr_race_rpt,
        :prac_ehr_age_doc, :prac_ehr_age_rpt, :prac_ehr_rpt_nonstd, :prac_ehr_rpt_hist,
        :prac_ehr_rpt_conf, :prac_ehr_rpt_trust, :prac_ehr_rpt_fee, :prac_ehr_satisfaction_survey,
        :prac_public_reporting, :prac_discuss_data, :prac_qual_report_data, :prac_qual_report_rec,
        :prac_qual_report_healthsystem, :prac_qual_report_hie, :prac_qual_report_primarycare,
        :prac_qual_report_hospnetwor, :prac_qual_report_external, :prac_qual_report_pbrn,
        :sna_freq, :sna_helpful, :sna_difference, :prac_registry_ivd, :prac_registry_hyp,
        :prac_registry_chol, :prac_registry_diab, :prac_registry_prev, :prac_registry_risk,
        :prac_registry_none, :prac_prev_guidelines_none, :prac_prev_guidelines_posted,
        :prac_prev_guidelines_agreed, :prac_prev_guidelines_orders,
        :prac_prev_guidelines_ehrprompts, :prac_chronic_guidelines_none,
        :prac_chronic_guidelines_posted, :prac_chronic_guidelines_agreed,
        :prac_chronic_guidelines_orders, :prac_chronic_guidelines_ehrprompts,
        :demo_prog_sim, :demo_prog_cpci, :demo_prog_tcpi, :demo_prog_chw, :demo_prog_pcmh,
        :demo_prog_mh_collab, :demo_prog_mh_riskred, :demo_prog_other, :demo_prog_specify,
        :prac_income_satisf, :prac_income_quality, :prac_income_perform, :prac_perform_quality,
        :prac_perform_resources, :prac_revenue, :prac_incentives_geographic,
        :prac_incentives_primarycare, :prac_incentives_carecoord, :prac_incentives_other,
        :prac_incentives_specify, :number_clinstaff, :fte_clinstaff, :number_offstaff,
        :fte_offstaff, :number_psychol, :fte_psychol, :number_sw, :fte_sw, :number_pharma,
        :fte_pharma, :number_other, :fte_other, :person_consult_front_office,
        :person_consult_back_office, :person_consult_office_manager, :person_consult_nurse,
        :person_consult_ma, :person_consult_clinician, :person_consult_other,
        :person_consult_other_specify
      )
    end
end
