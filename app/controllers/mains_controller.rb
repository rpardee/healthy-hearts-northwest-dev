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
  end

end
