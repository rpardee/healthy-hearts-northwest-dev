class ManagerNotesController < ApplicationController
  before_action :set_manager_note, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_partner!

  # GET /manager_notes
  # GET /manager_notes.json
  def index
    @manager_notes = policy_scope(ManagerNote).order(updated_at: :desc)
  end

  # GET /manager_notes/1
  # GET /manager_notes/1.json
  def show
  end

  # GET /manager_notes/new
  def new
    @site = current_user.site
    set_manager_barriers
    @site.manager_notes.build unless @site.manager_notes.length > 0
  end

  # GET /manager_notes/1/edit
  def edit
    @site = current_user.site
    set_manager_notes
  end

  # POST /manager_notes
  # POST /manager_notes.json
  def create
    @manager_note = ManagerNote.new(manager_note_params)

    respond_to do |format|
      if @manager_note.save
        format.html { redirect_to manager_notes_path, notice: 'Manager note was successfully created.' }
        format.json { render :show, status: :created, location: @manager_note }
      else
        format.html { render :new }
        format.json { render json: @manager_note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /manager_notes/1
  # PATCH/PUT /manager_notes/1.json
  def update
    respond_to do |format|
      if @manager_note.update(manager_note_params)
        format.html { redirect_to manager_notes_path, notice: 'Manager note was successfully updated.' }
        format.json { render :show, status: :ok, location: @manager_note }
      else
        format.html { render :edit }
        format.json { render json: @manager_note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /manager_notes/1
  # DELETE /manager_notes/1.json
  def destroy
    @manager_note.destroy
    respond_to do |format|
      format.html { redirect_to manager_notes_url, notice: 'Manager note was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_manager_note
      @manager_note = ManagerNote.find(params[:id])
    end

    def set_manager_notes
      @manager_barriers = @site.manager_notes
        .where(manager_note_type: ManagerNote::MANAGER_NOTE_TYPE_VALS["Barrier"])
        .order(updated_at: :desc)
      @manager_successes = @site.manager_notes
        .where(manager_note_type: ManagerNote::MANAGER_NOTE_TYPE_VALS["Success"])
        .order(updated_at: :desc)
      @manager_support = @site.manager_notes
        .where(manager_note_type: ManagerNote::MANAGER_NOTE_TYPE_VALS["Support"])
        .order(updated_at: :desc)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def manager_note_params
      params[:manager_note]
    end
end
