json.array!(@leagues) do |league|
  json.extract! league, :id, :title, :description, :division_1, :division_2, :division_3, :division_4, :division_5
  json.url league_url(league, format: :json)
end
