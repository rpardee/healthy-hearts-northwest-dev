class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_partner!

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
    @event = Event.new
    @practice = Practice.where(id: params[:practice_id]).first
    if @practice
      @practice_id = @practice.id
      @recruiter_id = @practice.recruiter.id if @practice.recruiter
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
    @practice_id = params[:practice_id]
    @practice = Practice.where(id: @practice_id).first
    @recruiter_id = @practice.recruiter.id if @practice.recruiter
  end

  # GET /events/1/edit
  def edit
    @practice_id = @event.practice_id
    @practice = Practice.where(id: @practice_id).first
    @recruiter_id = @practice.recruiter.id if @practice.recruiter
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
    # @practice_id = @event.practice_id
    # @practice = Practice.find(@practice_id).first
    # @event.current_partner = current_partner.name

    respond_to do |format|
      if @event.save
        format.html { redirect_to partner_path(@event.partner_id), notice: 'Activity was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    @practice_id = @event.practice_id
    @practice = Practice.where(id: @practice_id).first
    @event.current_partner = current_partner.name
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to partner_path(@event.partner_id), notice: 'Activity was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Activity was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params[:event].permit(:practice_id, :partner_id, :schedule_dt,
        :schedule_tm, :contact_type, :contact_type_other, :outcome,
        :outcome_dt, :description,
        :outcome_pal_sent, :outcome_pal_returned, :outcome_complete_ehr,
        :outcome_complete_characteristics)
    end
end
