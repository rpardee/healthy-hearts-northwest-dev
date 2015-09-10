class MainsController < ApplicationController

  # GET /mains
  def index
  	@test_partner = Partner.second
  end

  # GET /mains/practice_survey_thanks
  def practice_survey_thanks
  end

end
