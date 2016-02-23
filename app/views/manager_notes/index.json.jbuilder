json.array!(@manager_notes) do |manager_note|
  json.extract! manager_note, :id
  json.url manager_note_url(manager_note, format: :json)
end
