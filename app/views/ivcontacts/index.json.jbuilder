json.array!(@ivcontacts) do |ivcontact|
  json.extract! ivcontact, :id
  json.url ivcontact_url(ivcontact, format: :json)
end
