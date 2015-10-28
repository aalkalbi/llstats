json.array!(@teams) do |team|
  json.extract! team, :id, :name, :division, :location, :debut
  json.url team_url(team, format: :json)
end
