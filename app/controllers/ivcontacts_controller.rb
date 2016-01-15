class IvcontactsController < ApplicationController
  before_action :set_ivcontact, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_partner!

  # GET /ivcontacts
  # GET /ivcontacts.json
  def index
    @ivcontacts = Ivcontact.all
  end

  # GET /ivcontacts/1
  # GET /ivcontacts/1.json
  def show
  end

  # GET /ivcontacts/new
  def new
    @practice = Practice.find(params[:coach_practice_id])
    @ivcontact = @practice.ivcontacts.build
    @personnel = Personnel.new
    @practice_name = @practice.name
    @contact_specific = @practice.next_inperson_contact
    @personnel_list = get_personnel_by_practice(@practice)
    get_continuing_change_tests(@practice)
    @ivcontact.high_leverage_change_tests.build unless @ivcontact.high_leverage_change_tests.length > 0
    set_contact_type_options
  end

  # GET /ivcontacts/1/edit
  def edit
    # @practice_id = params[:coach_practice_id]
    @practice         = Practice.find(params[:coach_practice_id])
    @practice_name    = Practice.find(@practice.id).name
    @personnel_list   = get_personnel_by_practice(@practice)
    @contact_specific = @ivcontact.contact_specific
    (@ivcontact.high_leverage_change_tests.count..2).each do
      @ivcontact.high_leverage_change_tests.build
    end
    set_contact_type_options
  end

  # POST /ivcontacts
  # POST /ivcontacts.json
  def create
    @ivcontact = Ivcontact.new(ivcontact_params)
    @practice = Practice.find(@ivcontact.practice_id)
    if Ivcontact::CONTACT_TYPE_VALS.key(@ivcontact.contact_type) == "Quarterly in-person visit"
      @ivcontact.contact_specific = @practice.next_inperson_contact
    end
    save_personnel_list(params[:ivcontact][:personnels])
    respond_to do |format|
      if @ivcontact.save
        format.html { redirect_to coach_practice_path(@practice), notice: 'IV Contact was successfully created.' }
        format.json { render :show, status: :created, location: @ivcontact }
      else
        format.html { render :new }
        format.json { render json: @ivcontact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ivcontacts/1
  # PATCH/PUT /ivcontacts/1.json
  def update
    # N.b., @ivcontact.contact_specific does not update. If a required in-person visit is
    # entered, the specific (1st-5th) contact cannot be changed.
    @practice = Practice.find(@ivcontact.practice_id)
    @coach = @practice.coach
    save_personnel_list(params[:ivcontact][:personnels])
    respond_to do |format|
      if @ivcontact.update(ivcontact_params)
        format.html { redirect_to coach_practice_path(@practice), notice: 'IV Contact was successfully updated.' }
        format.json { render :show, status: :ok, location: @ivcontact }
      else
        format.html { render :edit }
        format.json { render json: @ivcontact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ivcontacts/1
  # DELETE /ivcontacts/1.json
  def destroy
    @ivcontact.destroy
    respond_to do |format|
      format.html { redirect_to ivcontacts_url, notice: 'Ivcontact was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ivcontact
      @ivcontact = Ivcontact.find(params[:id])
    end

    def set_contact_type_options
      # If this is changed, also update Ivcontact::CONTACT_TYPE_VALS
      @grouped_options_for_contact_type = { '15 required monthly contacts' => [['Quarterly in-person visit', 1],
        ['Other required contact', 2]], 'Ad-hoc' => [['Other ad-hoc contact', 9]] }
    end

    def get_personnel_by_practice(practice)
      Personnel.includes(:ivcontacts).where(practice_id: @practice.id).order("name")
    end

    def save_personnel_list(personnel_params)
      @ivcontact.personnels.delete_all
      if personnel_params.nil? == false
        personnel = Personnel.where(id: personnel_params.keys)
        @ivcontact.personnels << personnel
      end
    end

    def get_continuing_change_tests(practice)
      last_inperson = practice.last_required_iv_contact
      if last_inperson
        continuing_tests = last_inperson.high_leverage_change_tests.where(test_status: 0)
        (0..3).each do |n|
          if continuing_tests[n]
            @ivcontact.high_leverage_change_tests << continuing_tests[n].dup
          else
            @ivcontact.high_leverage_change_tests << HighLeverageChangeTest.new
          end
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ivcontact_params
      params[:ivcontact].permit(:contact_type, :contact_specific, :contact_dt, :contact_mode,
        :contact_duration, :contact_comments, :topic_ehr_vendor, :topic_3rdparty_vendor,
        :topic_custom_query, :topic_validate_data, :topic_meaningful_use, :topic_cqm_report,
        :topic_data_error, :topic_coding, :topic_hit_display, :topic_reminder, :topic_pcmha,
        :topic_abcs, :topic_brainstorm, :topic_observe_flow, :topic_share, :topic_connect,
        :topic_resource, :topic_planning, :topic_workflow, :topic_roles, :topic_qi_support,
        :topic_consensus, :topic_review_data, :topic_qi_display, :topic_huddle, :topic_self_assessment,
        :topic_leadership, :topic_other, :topic_other_specify,
        :topic_review_guideline, :topic_discuss_measurement,
        :milestone_evidence_progress,
        :milestone_evidence_active, :milestone_evidence_discussed, :milestone_data_progress,
        :milestone_data_active, :milestone_data_discussed, :milestone_qi_progress,
        :milestone_qi_active, :milestone_qi_discussed, :milestone_atrisk_progress,
        :milestone_atrisk_active, :milestone_atrisk_discussed, :milestone_task_progress,
        :milestone_task_active, :milestone_task_discussed, :milestone_selfmgmt_progress,
        :milestone_selfmgmt_active, :milestone_selfmgmt_discussed,
        :milestone_community_progress, :milestone_community_active,
        :milestone_community_discussed, :gyr, :gyr_notes, :tier,
        :pcmha_1, :pcmha_2, :pcmha_3, :pcmha_4, :pcmha_5, :pcmha_6, :pcmha_7, :pcmha_8, :pcmha_9,
        :pcmha_10, :pcmha_11, :pcmha_12, :pcmha_13, :pcmha_14, :pcmha_15, :pcmha_16, :pcmha_17,
        :pcmha_18, :pcmha_19, :pcmha_20, :prach_change_ehr_which,
        :prac_change_ehr, :prac_change_newlocation, :prac_change_lost_clin,
        :prac_change_lost_om, :prac_change_boughtover, :prac_change_billing,
        :prac_change_other, :prac_change_specify, :practice_id, :observations,
        :status_text, :smsvy_name, :smsvy_email, :hit_ehr_vendor, :hit_tier, :hit_quality, :hit_quality_explain,
        high_leverage_change_tests_attributes: [:id, :_destroy, :description, :test_status, :comments, :embed_evidence, :use_data, :xfunc_qi,
                                                :id_at_risk, :manage_pops, :self_management, :resource_linkages,
                                                :hlc_other],
        personnels_attributes: [:id, :_destroy, :name, :role, :role_other])
    end
end
