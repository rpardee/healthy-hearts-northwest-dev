class CoachPracticesController < ApplicationController
  before_action :set_practice, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_partner!

  # List of all practices for that Coach
  # GET /coach_practices/1/list
  def list
    @coach = Partner.find(params[:id])
    @practices = policy_scope(Practice).where(coach_id: @coach.id).order("name")
  end

  # TODO: Limit this to admins
  # Probably limit to enrolled practices?
	# GET /coach_practices
  def index
    @practices = policy_scope(Practice).order("name")
  end

  # GET /coach_practices/1/edit
  def edit
    @coach_id = @practice.coach.id if @practice.coach
    @visit1 = Ivcontact.where(practice_id: @practice.id, contact_specific: 1).first
    @visit2 = Ivcontact.where(practice_id: @practice.id, contact_specific: 2).first
    @visit3 = Ivcontact.where(practice_id: @practice.id, contact_specific: 3).first
    @visit4 = Ivcontact.where(practice_id: @practice.id, contact_specific: 4).first
    @visit5 = Ivcontact.where(practice_id: @practice.id, contact_specific: 5).first
  end

  # PATCH/PUT /coach_practices/1
  def update
    coach_id = params[:coach_id]
    respond_to do |format|
      if @practice.update(:coach_id => coach_id)
        format.html { redirect_to list_coach_practice_path(coach_id), notice: 'Practice was successfully updated.' }
        format.json { render :show, status: :ok, location: @practice }
      else
        format.html { render :edit }
        format.json { render json: @practice.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_practice
      @practice = Practice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def practice_params
      params[:practice].permit(:name, :address, :phone, :url, :coach_id,
        personnels_attributes: [:id, :_destroy, :name, :role, :role_other])
    end
end
