class PracticeSurvey < ActiveRecord::Base
	belongs_to :practice
	validates_presence_of :name_survey_completer

	MAX_SURVEY_PAGES = 3

	YN12_VALS = {
		"Yes" => 1,
		"No" => 2
	}
end
