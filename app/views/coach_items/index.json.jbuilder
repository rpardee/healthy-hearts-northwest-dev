json.array!(@coach_items) do |coach_item|
  json.extract! coach_item, :id
  json.url coach_item_url(coach_item, format: :json)
end
