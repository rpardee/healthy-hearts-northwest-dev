class CoachPracticesController < ApplicationController
  before_action :set_practice, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_partner!

  # GET /coach_practices/list
  def list
    @practices = policy_scope(Practice).order("name")
  end

	# GET /coach_practices
  def index
  	# Limit this in policies
    @practices = policy_scope(Practice).order("name")
  end

  # GET /coach_practices/1/edit
  def edit
    @coach_id = @practice.coach.id if @practice.coach
  end

  # PATCH/PUT /coach_practices/1
  def update
    @partner = Partner.find(params[:coach_partner])
    @practice.partners.destroy_all
    @practice.partners << @partner
    respond_to do |format|
      if @practice.update(practice_params)
        format.html { redirect_to coach_practices_path, notice: 'Practice was successfully updated.' }
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
      params[:practice].permit(:name, :address, :phone, :url,
        personnels_attributes: [:id, :_destroy, :name, :role, :role_other])
    end
end
