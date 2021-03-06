class PersonnelsController < ApplicationController
  before_action :set_personnel, only: [:show, :edit, :update, :destroy]

  # GET /personnels
  # GET /personnels.json
  def index
    @personnels = Personnel.all
  end

  # GET /personnels/1
  # GET /personnels/1.json
  def show
  end

  # GET /personnels/new
  def new
    @personnel = Personnel.new
  end

  # GET /personnels/1/edit
  def edit
  end

  # POST /personnels
  # POST /personnels.json
  def create
    @personnel = Personnel.new(personnel_params)
    # partner_id = Practice.find(@personnel.practice_id).partner_id
    # @personnel.current_partner = current_partner.name

    respond_to do |format|
      if @personnel.save
        # format.html { redirect_to partner_practice_path(partner_id, @personnel.practice_id), notice: 'Personnel was successfully added.' }
        format.html { redirect_to partner_path(current_partner), notice: 'Personnel was successfully added.' }
        # format.json { render :show, status: :created, location: @personnel }
        # Return the ID of the created object for use in ivcontacts.coffee
        format.json { render json: {"id" => @personnel.id, "name" => @personnel.name,
          "role_name" => Personnel::ROLE_VALS.key(@personnel.role), "email1" => @personnel.email1 } }
      else
        format.html { render :new }
        format.json { render json: @personnel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /personnels/1
  # PATCH/PUT /personnels/1.json
  def update
    # partner_id = Practice.find(@personnel.practice_id).partner_id
    # @personnel.current_partner = current_partner.name
    respond_to do |format|
      if @personnel.update(personnel_params)
        # format.html { redirect_to partner_practice_path(partner_id, @personnel.practice_id), notice: 'Personnel was successfully updated.' }
        format.html { redirect_to partner_path(current_partner), notice: 'Personnel was successfully updated.' }
        format.json { render :show, status: :ok, location: @personnel }
      else
        format.html { render :edit }
        format.json { render json: @personnel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /personnels/1
  # DELETE /personnels/1.json
  def destroy
    @personnel.destroy
    respond_to do |format|
      format.html { redirect_to personnels_url, notice: 'Personnel was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_personnel
      @personnel = Personnel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def personnel_params
      params[:personnel].permit(:practice_id, :name, :role, :role_other,
        :phone1, :phone1_best, :phone2, :phone2_best,
        :email1, :email1_best, :email2, :email2_best,
        :ehr_extractor, :ehr_helper, :ehr_cqm,
        :site_contact_primary, :site_contact_secondary, :site_contact_champion)
    end
end
