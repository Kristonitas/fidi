json.leaderboard do
  json.array!(@leaderboard) do |user|
    json.user_id user.id
    json.user_name user.name
    json.first_name user.first_name
    json.last_name user.last_name
    json.total_score user.total_score
  end
end