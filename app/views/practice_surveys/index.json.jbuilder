json.array!(@practice_surveys) do |practice_survey|
  json.extract! practice_survey, :id
  json.url practice_survey_url(practice_survey, format: :json)
end
