json.booth do
  json.extract! @booth, :id, :name, :description, :image_url, :pointer_image_url
end

json.highscores do
  json.array!(@highscores) do |attempt|
    json.score attempt.score
    json.user_name attempt.user.name
    json.user_id attempt.user.id
  end
end