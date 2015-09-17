class IvcontactsController < ApplicationController
  before_action :set_ivcontact, only: [:show, :edit, :update, :destroy]

  # GET /ivcontacts
  # GET /ivcontacts.json
  def index
    @ivcontacts = Ivcontact.all
  end

  # GET /ivcontacts/1
  # GET /ivcontacts/1.json
  def show
  end

  # GET /ivcontacts/new
  def new
    @ivcontact = Ivcontact.new
  end

  # GET /ivcontacts/1/edit
  def edit
  end

  # POST /ivcontacts
  # POST /ivcontacts.json
  def create
    @ivcontact = Ivcontact.new(ivcontact_params)

    respond_to do |format|
      if @ivcontact.save
        format.html { redirect_to @ivcontact, notice: 'Ivcontact was successfully created.' }
        format.json { render :show, status: :created, location: @ivcontact }
      else
        format.html { render :new }
        format.json { render json: @ivcontact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ivcontacts/1
  # PATCH/PUT /ivcontacts/1.json
  def update
    respond_to do |format|
      if @ivcontact.update(ivcontact_params)
        format.html { redirect_to @ivcontact, notice: 'Ivcontact was successfully updated.' }
        format.json { render :show, status: :ok, location: @ivcontact }
      else
        format.html { render :edit }
        format.json { render json: @ivcontact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ivcontacts/1
  # DELETE /ivcontacts/1.json
  def destroy
    @ivcontact.destroy
    respond_to do |format|
      format.html { redirect_to ivcontacts_url, notice: 'Ivcontact was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ivcontact
      @ivcontact = Ivcontact.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ivcontact_params
      params[:ivcontact]
    end
end
