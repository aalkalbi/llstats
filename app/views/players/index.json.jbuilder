json.array!(@players) do |player|
  json.extract! player, :id, :first_name, :last_name, :dob, :debut, :height, :weight, :coach_id, :postal_code, :rank, :team_id
  json.url player_url(player, format: :json)
end
