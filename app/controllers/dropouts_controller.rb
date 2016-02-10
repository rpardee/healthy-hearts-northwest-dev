class DropoutsController < ApplicationController
  before_action :set_practice, only: [ :edit, :update ]
  before_action :authenticate_partner!

	# GET /dropouts
	def index
    @practices = policy_scope(Practice).order("name")
  end

  # GET /dropouts/1/edit
  def edit
  	@make_inactive = @practice.active
  	@today = Date.today.strftime("%m/%d/%Y")
  	if @make_inactive == true
  		@dropout_desc = "drop #{@practice.name} from"
  		@submit_button_text = "Drop from H2N"
	  	@inactive_rsn = Practice::INACTIVE_RSN_VALS["Dropout"]
  	elsif @make_inactive == false
  		@dropout_desc = "reinstate #{@practice.name} into"
  		@submit_button_text = "Re-enter H2N"
	  	@inactive_rsn = Practice::INACTIVE_RSN_VALS["Active"]
  	end
  end

  # PATCH/PUT /dropouts/1
  def update
    respond_to do |format|
      if @practice.update(practice_params)
        format.html { redirect_to practices_path, notice: 'Practice was successfully updated.' }
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
      params[:practice].permit(:active, :inactive_rsn, :drop_dt,
      	:drop_reentry_dt, :drop_determine, :drop_contact_num,
      	:drop_contact_who, :drop_notify_who, :drop_notify_how,
				:drop_notify_dt, :drop_notify_rsn_demanding,
				:drop_notify_rsn_priority, :drop_notify_rsn_barrier,
				:drop_notify_rsn_relevant, :drop_notify_rsn_other,
				:drop_notify_rsn_specify, :drop_decide_who, :drop_decide_why,
				:drop_comments, :reentry_who, :reentry_comment)
    end
end
