class PracticesController < ApplicationController
  before_action :set_practice, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_partner!

  # GET /practices
  # GET /practices.json
  def index
    @practices = Practice.all
  end

  # GET /practices/1
  # GET /practices/1.json
  def show
    @personnel = Personnel.new
  end

  # GET /practices/new
  def new
    @practice = Practice.new
    @partner_id = params[:partner_id]
  end

  # GET /practices/1/edit
  def edit
    @recruiter_id = @practice.recruiter.id if @practice.recruiter
  end

  # POST /practices
  # POST /practices.json
  def create
    @practice = Practice.new(practice_params)
    if params[:recruiter_partner].present?
      @partner = Partner.find(params[:recruiter_partner])
      @practice.partners << @partner
    end

    respond_to do |format|
      if @practice.save
        format.html { redirect_to partner_path(current_partner), notice: 'Practice was successfully created.' }
        format.json { render :show, status: :created, location: @practice }
      else
        format.html { render :new }
        format.json { render json: @practice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /practices/1
  # PATCH/PUT /practices/1.json
  def update
    respond_to do |format|
      if @practice.update(practice_params)
        # Delete the currently associated partner
        delete_sql = "DELETE FROM partners_practices WHERE " +
          "partner_id = #{params[:original_recruiter]} AND practice_id = #{@practice.id};"
        ActiveRecord::Base.connection.execute delete_sql
        if params[:recruiter_partner].present?
          # Add the new associated partner (if any)
          insert_sql = "INSERT INTO partners_practices (partner_id, practice_id) " +
            "VALUES (#{params[:recruiter_partner]}, #{@practice.id});"
          ActiveRecord::Base.connection.execute insert_sql
        end
        format.html { redirect_to partner_path(current_partner), notice: 'Practice was successfully updated.' }
        format.json { render :show, status: :ok, location: @practice }
      else
        format.html { render :edit }
        format.json { render json: @practice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /practices/1
  # DELETE /practices/1.json
  def destroy
    @practice.destroy
    respond_to do |format|
      format.html { redirect_to practices_url, notice: 'Practice was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_practice
      @practice = Practice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def practice_params
      params[:practice].permit(:name, :address, :phone, :url,
        :primary_care, :email, :parent_organization,
        :prac_ehr_yr, :prac_ehr, :prac_ehrname, :prac_ehrversion,
        :prac_ehrname_other, :prac_ehr_mu, :prac_mu_stage1, :prac_mu_stage2,
        :prac_ehr_extractdata, :prac_ehr_person_extractdata,
        :prac_ehr_person_extractdata_other, :prac_it_support,
        :prac_ehr_vendor, :prac_share_healthinfo, :prac_cqm,
        :prac_cqm_submit, :prac_cqm_who, :prac_ehr_satisfaction,
        :prac_new_ehr, :elig_phys_count, :elig_phys_fte,
        :number_clinicians, :fte_clinicians,
        :prac_own_other_specify, :prac_own_yrs,
        :elig_clinic_count, :prac_spec_mix, :prac_pcmh,
        :prac_aco_join_medicaid, :interest_why, :interest_expect,
        :interest_challenge, :recruitment_source, :recruitment_source_referral,
        :prac_ehr_mu_yr, :interest_yn, :interest_why_not, :interest_why_not_other,
        :interest_contact_month, :prac_state, :prac_own_clinician,
        :prac_own_hosp, :prac_own_hmo, :prac_own_fqhc, :prac_own_nonfed, :prac_own_academic,
        :prac_own_fed, :prac_own_rural, :prac_own_ihs, :prac_own_other,
        :prac_aco_medicaid, :prac_aco_medicare, :prac_aco_commercial,
        :prac_aco_other, :prac_aco_none, :prac_aco_dk,
        :prac_aco_join_medicare, :prac_aco_join_commercial,
        :zip_code, :city,
        personnels_attributes: [:id, :_destroy, :name, :role, :role_other, :phone1,
          :phone1_best, :phone2, :phone2_best, :email1, :email1_best,
          :email2, :email2_best, :ehr_extractor, :ehr_helper, :ehr_cqm,
          :site_contact_primary, :site_contact_secondary, :site_contact_champion])
    end
end
