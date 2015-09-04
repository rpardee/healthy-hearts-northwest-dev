class PracticeSurvey < ActiveRecord::Base
	belongs_to :practice
	validates_presence_of :name_respondent

	# Use :survey_key as the id parameter for the survey
	def to_param
		survey_key
	end

	def get_id_from_survey(survey_key)
		survey_key[3..7]
	end

	YN12_VALS = {
		"Yes" => 1,
		"No" => 2
	}
end
