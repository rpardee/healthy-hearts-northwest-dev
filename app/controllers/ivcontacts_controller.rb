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
    @ivcontact = Ivcontact.new
    @practice_id = params[:coach_practice_id]
    @practice = Practice.find(@practice_id)
    @practice_name = @practice.name
    @contact_specific = @practice.next_inperson_contact
    @personnel_list = get_personnel_list(Personnel.where(practice_id: @practice.id).order("name"))
  end

  # GET /ivcontacts/1/edit
  def edit
    @practice_id = params[:coach_practice_id]
    @practice = Practice.find(@practice_id)
    @practice_name = Practice.find(@practice_id).name
    @personnel_list = get_personnel_list(Personnel.where(practice_id: @practice.id).order("name"))
  end

  # POST /ivcontacts
  # POST /ivcontacts.json
  def create
    @ivcontact = Ivcontact.new(ivcontact_params)
    @coach = Practice.find(@ivcontact.practice_id).coach
    # Remove the first (template) element and save the rest
    personnel_array = params[:ivcontact][:personnels]
    if !personnel_array.nil? && personnel_array.count > 1
      fake = personnel_array.shift
      personnel = Personnel.where(id: personnel_array)
      @ivcontact.personnels << personnel
    end
    respond_to do |format|
      if @ivcontact.save
        format.html { redirect_to list_coach_practice_path(@coach.id), notice: 'IV Contact was successfully created.' }
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
    @coach = Practice.find(@ivcontact.practice_id).coach
    respond_to do |format|
      if @ivcontact.update(ivcontact_params)
        format.html { redirect_to list_coach_practice(@coach), notice: 'IV Contact was successfully updated.' }
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

    def get_personnel_list(personnel)
      if personnel.nil?
        Array.new
      else
        personnel.map {|p| [p.name, p.id]}
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
        :topic_leadership, :topic_other, :topic_other_specify, :milestone_evidence_progress,
        :milestone_evidence_active, :milestone_evidence_discussed, :milestone_data_progress,
        :milestone_data_active, :milestone_data_discussed, :milestone_qi_progress,
        :milestone_qi_active, :milestone_qi_discussed, :milestone_atrisk_progress,
        :milestone_atrisk_active, :milestone_atrisk_discussed, :milestone_task_progress,
        :milestone_task_active, :milestone_task_discussed, :milestone_selfmgmt_progress,
        :milestone_selfmgmt_active, :milestone_selfmgmt_discussed,
        :milestone_community_progress, :milestone_community_active,
        :milestone_community_discussed, :gyr, :gyr_notes, :tier,
        :pcqm_1, :pcqm_2, :pcqm_3, :pcqm_4, :pcqm_5, :pcqm_6, :pcqm_7, :pcqm_8, :pcqm_9,
        :pcqm_10, :pcqm_11, :pcqm_12, :pcqm_13, :pcqm_14, :pcqm_15, :pcqm_16, :pcqm_17,
        :pcqm_18, :pcqm_19, :pcqm_20, :pcqm_21, :pcqm_22, :pcqm_23, :pcqm_24, :pcqm_25,
        :pcqm_26, :pcqm_27, :pcqm_28, :pcqm_29, :pcqm_30, :pcqm_31, :pcqm_32, :pcqm_33,
        :pcqm_34, :pcqm_35, :pcqm_36,
        :prac_change_ehr, :prac_change_newlocation, :prac_change_lost_clin,
        :prac_change_lost_om, :prac_change_boughtover, :prac_change_billing,
        :prac_change_other, :prac_change_specify, :practice_id)
    end
end
