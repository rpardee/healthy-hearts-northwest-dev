class SurveysController < ApplicationController
  before_action :authenticate_partner!
  def index
    @page_title = "Practices eligible for practice and/or staff Surveys"
    @practices = policy_scope(Practice).includes(:site).where(pal_status_cached: 'Returned').order(:site_id, :name)
  end
end
