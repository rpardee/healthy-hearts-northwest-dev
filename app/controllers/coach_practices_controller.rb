class CoachPracticesController < ApplicationController
  before_action :set_practice, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_partner!

  # List of all practices for that Coach
  # GET /coach_practices/1/list
  def list
    @coach = Partner.find(params[:id])
    @practices = policy_scope(Practice).where(coach_id: @coach.id).order(active: :desc, name: :asc)
  end

  # TODO: Limit this to admins
  # Probably limit to enrolled practices?
	# GET /coach_practices
  def index
    @practices = policy_scope(Practice).order("name")
  end

  def show
    @aa_hlcts = Array.new
    @practice                 = Practice.find(params[:id])
    @coach_name               = @practice.coach.name
    @visit1                   = @practice.get_inperson_visit(1)
    @visit2                   = @practice.get_inperson_visit(2)
    @visit3                   = @practice.get_inperson_visit(3)
    @visit4                   = @practice.get_inperson_visit(4)
    @visit5                   = @practice.get_inperson_visit(5)
    @qica_summary             = @practice.get_qica_summary
    action_item               = @practice.coach_items.where(item_type: CoachItem::ITEM_TYPE_VALS["Action item for practice"])
    @action_item_complete     = action_item.where(complete: true)
    @action_item_incomplete   = action_item.where(complete: false)
    coach_item                = @practice.coach_items.where(item_type: CoachItem::ITEM_TYPE_VALS["Coach follow-up"])
    @coach_item_complete      = coach_item.where(complete: true)
    @coach_item_incomplete    = coach_item.where(complete: false)
    @coach_item               = @practice.coach_items.create

    # For the last contact we want all HLCTs.  For all others we only want adopted/abandoned.
    ld = @practice.last_required_iv_contact_date
    # custom sort adopted/abandoned at the bottom
    @practice.ivcontacts.order(contact_dt: :desc).each do |ivc|
      if ivc.contact_dt == ld
        filter = "1 = 1"
      else
        filter = "test_status in (1, 2)"
      end
      ivc.high_leverage_change_tests.where(filter).each do |aa|
        @aa_hlcts << aa unless aa.description.blank?
      end
    end
  end

  # GET /coach_practices/1/edit
  def edit
    @coach_id = @practice.coach.id if @practice.coach
    # Required for New Item quick add
    @coach_item = CoachItem.new
    @visit1 = @practice.get_inperson_visit(1)
    @visit2 = @practice.get_inperson_visit(2)
    @visit3 = @practice.get_inperson_visit(3)
    @visit4 = @practice.get_inperson_visit(4)
    @visit5 = @practice.get_inperson_visit(5)
  end

  # PATCH/PUT /coach_practices/1
  # coach_practices#edit performed via Admin area - coach assignment to practices - so it should redirect
  #   to the coach list (coach_practices#index)
  def update
    coach_id = params[:coach_id]
    respond_to do |format|
      if @practice.update(:coach_id => coach_id)
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
      params[:practice].permit(:name, :address, :phone, :url, :coach_id,
        personnels_attributes: [:id, :_destroy, :name, :role, :role_other],
        coach_items_attributes: [:id, :_destroy, :item_type, :add_dt, :complete, :complete_dt,
          :notes, :practice_id])
    end
end
