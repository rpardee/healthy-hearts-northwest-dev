class PartnersController < ApplicationController
  before_action :set_partner, only: [:edit, :update, :destroy]
  before_action :authenticate_partner!

  # GET /partners/list
  def list
    @partners = Partner.where("name != '(not assigned)'").order("name")
  end

  # GET /partners
  # GET /partners.json
  def index
    # Set these to display proper data
    @partners = policy_scope(Partner)
    @practices = policy_scope(Practice)
    @appointments = policy_scope(Event).where('schedule_dt >= ?', Date.today)
    # This populates the Partner Name dropdown
    @partner = Partner.new(id: 0, name: 'ALL')
    # Required for New Event quick add
    @event = Event.new
  end

  # GET /partners/1
  # GET /partners/1.json
  def show
    @recruiter_or_coach_override = "Recruiter"
    @partner = Partner.find(params[:id])
    @event = Event.new
    # If this partner is from GHRI, set a var that the view can use to show every damn practice.
    if @partner.site.id == 0 then
      @selected_partner_id = 0
    else
      @selected_partner_id = @partner.id
    end
  end

  # GET /partners/new
  def new
    @partner = Partner.new
  end

  def admin_new
    @partner = Partner.new
  end

  # GET /partners/1/edit
  def edit
  end

  # POST /partners
  # POST /partners.json
  def create
    @partner = Partner.new(partner_params)

    respond_to do |format|
      if @partner.save
        format.html { redirect_to list_partners_path, notice: 'Partner was successfully created.' }
        format.json { render :show, status: :created, location: @partner }
      else
        format.html { render :new }
        format.json { render json: @partner.errors, status: :unprocessable_entity }
      end
    end
  end

  def admin_create
    @partner = Partner.new(partner_params)

    respond_to do |format|
      if @partner.save
        format.html { redirect_to list_partners_path, notice: 'Partner was successfully created.' }
        format.json { render :show, status: :created, location: @partner }
      else
        format.html { render :new }
        format.json { render json: @partner.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /partners/1
  # PATCH/PUT /partners/1.json
  def update
    params[:partner] = params[:partner].reject{|_,v| v.blank?}
    respond_to do |format|
      if @partner.update(partner_params)
        format.html { redirect_to list_partners_path, notice: 'Partner was successfully updated.' }
        format.json { render :show, status: :ok, location: @partner }
      else
        format.html { render :edit }
        format.json { render json: @partner.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /partners/1
  # DELETE /partners/1.json
  def destroy
    @partner.destroy
    respond_to do |format|
      format.html { redirect_to list_partners_url, notice: 'Partner was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_partner
      @partner = Partner.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def partner_params
      params[:partner].permit(:site_id, :name, :email, :role, :recruiter, :coach,
        :password, :password_confirmation)
    end
end
