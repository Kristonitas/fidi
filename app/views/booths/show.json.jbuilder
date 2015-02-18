json.booth do
  json.extract! @booth, :id, :name, :description
end

json.highscores do
  json.array!(@highscores) do |attempt|
    json.score attempt.score
    json.user_name attempt.user.name
  end
end