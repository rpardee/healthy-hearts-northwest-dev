class CoachAssignmentsController < ApplicationController
  before_action :authenticate_partner!

  def index
    @coaches = policy_scope(Partner).order(:name).all
    respond_to do |format|
      format.html
      format.csv
    end
  end

	# GET /coach_assignments/1/edit
  def edit
  	@coach = Partner.find(params[:id])
  	@practices = policy_scope(Practice).where(coach_id: @coach.id).order(:name)
  	@practices_unselected = policy_scope(Practice).where("pal_status_cached = 'Returned' AND (coach_id != ? or coach_id IS NULL)", @coach.id)
  end

  # PATCH/PUT /coach_assignments/1
  # PATCH/PUT /coach_assignments/1.json
  def update
    @coach = Partner.find(params[:id])
    success = true
    Practice.where(coach_id: @coach.id).update_all(coach_id: nil)
  	params[:practice_id].reject(&:empty?).each do |i|
      success = Practice.find(i).update(coach_id: @coach.id)
    end
    respond_to do |format|
      if success
        format.html { redirect_to edit_coach_assignment_path(@coach),
          notice: 'Practice assignments were successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end
end
