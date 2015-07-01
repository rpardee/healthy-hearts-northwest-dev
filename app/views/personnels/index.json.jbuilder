json.array!(@personnels) do |personnel|
  json.extract! personnel, :id
  json.url personnel_url(personnel, format: :json)
end
