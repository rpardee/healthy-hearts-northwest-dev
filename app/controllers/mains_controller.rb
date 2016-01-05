class MainsController < ApplicationController
	before_action :authenticate_partner!, only: :admin_area

  # GET /mains
  def index
  	@test_partner = Partner.second
  end

  # GET /mains/practice_survey_thanks
  def practice_survey_thanks
  end

  def admin_area
    @page_title = "Site Admin Area"
  end
  def supervisor_area
    @page_title = "Manager Area"
  end
  def practice_contacts
    @page_title = "Practice Contacts"
    @practices = policy_scope(Practice).where(pal_status_cached: 'Returned').order(:name)
  end
  def practice_progress
    @page_title = "Practice Progress"
    @practices = policy_scope(Practice).where(pal_status_cached: 'Returned').order(:name)
  end
  def practice_lifetime
    @practice = policy_scope(Practice).find(params[:id])
    @page_title = "Lifetime of #{@practice.name}"
  end
end
