class CoachItemsController < ApplicationController
  before_action :set_coach_item, only: [:show, :edit, :update, :destroy]

  # GET /coach_items
  # GET /coach_items.json
  def index
    @coach_items = CoachItem.all
  end

  # GET /coach_items/1
  # GET /coach_items/1.json
  def show
  end

  # GET /coach_items/new
  def new
    @coach_item = CoachItem.new
    @practice = Practice.find(params[:coach_practice_id])
  end

  # GET /coach_items/1/edit
  def edit
    @practice = Practice.find(params[:coach_practice_id])
  end

  # POST /coach_items
  # POST /coach_items.json
  def create
    @coach_item = CoachItem.new(coach_item_params)

    respond_to do |format|
      if @coach_item.save
        format.html { redirect_to coach_practice_path(@coach_item.practice_id), notice: 'Coach item was successfully created.' }
        format.json { render :show, status: :created, location: @coach_item }
      else
        format.html { render :new }
        format.json { render json: @coach_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /coach_items/1
  # PATCH/PUT /coach_items/1.json
  def update
    respond_to do |format|
      if @coach_item.update(coach_item_params)
        format.html { redirect_to coach_practice_path(@coach_item.practice_id), notice: 'Coach item was successfully updated.' }
        format.json { render :show, status: :ok, location: @coach_item }
      else
        format.html { render :edit }
        format.json { render json: @coach_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coach_items/1
  # DELETE /coach_items/1.json
  def destroy
    @coach_item.destroy
    respond_to do |format|
      format.html { redirect_to coach_items_url, notice: 'Coach item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coach_item
      @coach_item = CoachItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def coach_item_params
      params[:coach_item].permit(:id, :_destroy, :item_type, :add_dt, :complete, :complete_dt,
        :notes, :practice_id)
    end
end
