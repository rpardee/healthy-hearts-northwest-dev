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
  end

  # POST /practices
  # POST /practices.json
  def create
    @practice = Practice.new(practice_params)

    respond_to do |format|
      if @practice.save
        format.html { redirect_to partner_path(params[:practice][:partner_id]), notice: 'Practice was successfully created.' }
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
        format.html { redirect_to partner_path(params[:practice][:partner_id]), notice: 'Practice was successfully updated.' }
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
      params[:practice].permit(:name, :partner_id, :address, :phone, :url,
        :primary_care, :email, :npi, :prac_ehr_yr, :prac_ehr, :prac_ehrname,
        :prac_ehrversion,
        :prac_ehrname_other, :prac_ehr_mu, :prac_mu_stage1, :prac_mu_stage2,
        :prac_ehr_extractdata, :prac_ehr_person_extractdata,
        :prac_ehr_person_extractdata_other, :prac_it_support,
        :prac_ehr_vendor, :prac_share_healthinfo, :prac_cqm,
        :prac_cqm_submit, :prac_cqm_who, :prac_ehr_satisfaction,
        :prac_new_ehr, :elig_phys_count, :elig_phys_fte,
        :elig_phys_count, :elig_phys_fte, :elig_ownership,
        :elig_ownership_other, :elig_ownership_years,
        :elig_clinic_count, :elig_specialty, :elig_pcmh,
        :elig_aco, :elig_aco_apply, :interest_why, :interest_expect,
        :interest_challenge, :recruitment_source, :recruitment_source_referral,
        personnels_attributes: [:id, :_destroy, :name, :role, :phone1,
          :phone1_best, :phone2, :phone2_best, :email1, :email1_best,
          :email2, :email1_best])
    end
end
