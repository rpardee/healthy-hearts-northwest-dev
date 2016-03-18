class SurveysController < ApplicationController
  before_action :authenticate_partner!
  def index
    @page_title = "External Survey Management"
    @surveys = policy_scope(Survey).all
  end

  def practice_survey_practices
    # All practices who have returned the PAL but have not already 'completed' their practice survey.
    @practices = survey_needing_practices('Practice')
    render 'index'
  end

  def staff_survey_practices
    @practices = survey_needing_practices('Staff')
    render 'index'
  end

  def import
    @results = Survey.import_excel(params[:file], params[:spreadsheet_type])
  end

private
  def survey_needing_practices(survey_type)
    allowed_sites = (policy_scope(Site).select(:id).map {|s| s.id}).join(', ')
    sql = "select s.status, p.*
          from  practices as p left join
                surveys as s
          on    p.id = s.practice_id        AND
                s.survey_type = '#{survey_type}'  AND
                s.status = 'complete'
          where p.site_id in (#{allowed_sites})   AND
                p.pal_status_cached = 'Returned'  AND
                s.practice_id IS NULL"
    return Practice.find_by_sql(sql)
  end

end
