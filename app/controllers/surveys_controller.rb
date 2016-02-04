class SurveysController < ApplicationController
  before_action :authenticate_partner!
  def index
    @page_title = "Practices eligible for practice and/or staff Surveys"
    @practices = policy_scope(Practice).includes(:site).where(pal_status_cached: 'Returned').order(:site_id, :name)
  end
  def show
    @survey_type = params[:id]
    case @survey_type
    when 'practice'
    when 'staff'
      @page_title = "Practices eligible for the STAFF survey"
      in_person = Ivcontact::CONTACT_TYPE_VALS["Quarterly in-person visit"]
      @practices = policy_scope(Practice).includes(:site, :ivcontacts).where("id in (select practice_id from ivcontacts where contact_type = #{in_person})").order(:site_id, :name)
      # render('staff_survey')
    else
      raise("Survey type #{@survey_type} unknown.")
      # redirect_to 'mains#supervisor_area', notice: "No such survey as #{@survey_type}"
    end
    if @practices then respond_to do |format|
        format.html {render(@survey_type)}
        format.csv {render(@survey_type)}
      end
    end
  end
end
