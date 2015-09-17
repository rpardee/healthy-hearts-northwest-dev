class PracticeSurvey < ActiveRecord::Base
	belongs_to :practice
	validates_presence_of :name_survey_completer
  has_paper_trail

	MAX_SURVEY_PAGES = 13

	YN12_VALS = {
		"Yes" => 1,
		"No" => 2
	}

	YNDK128_VALS = {
		"Yes" => 1,
		"No" => 2,
		"Don't know" => 8
	}

	LIKERT15_VALS = {
		"Strongly disagree" => 1,
		"Somewhat disagree" => 2,
		"Neither agree nor disagree" => 3,
		"Somewhat agree" => 4,
		"Strongly agree" => 5,
		"N/A" => 8
	}

	RARELY13_VALS = {
		"Rarely" => 1,
		"Sometimes" => 2,
		"Often" => 3
	}

	HELPFUL13_VALS = {
		"Not very helpful" => 1,
		"Somewhat helpful" => 2,
		"Extremely helpful" => 3
	}

	CQM_VALS = {
		"Currently able to generate data" => 1,
		"It is feasible" => 2,
		"It is feasible with workflow modifications/changes to EHR" => 3,
		"It is not feasible" => 4,
		"I don't know" => 8
	}

	SATISFIED14_VALS = {
		"Very satisfied" => 1,
		"Somewhat satisfied" => 2,
		"Somewhat dissatisfied" => 3,
		"Very dissatisfied" => 4
	}

	DISCUSS_DATA_VALS = {
		"Never" => 1,
		"Infrequently" => 2,
		"Often" => 3,
		"Not applicable/Solo practice" => 4,
		"Don't know" => 8
	}
end
