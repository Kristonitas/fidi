json.leaderboard do
  json.array!(@leaderboard) do |user|
    json.user_id user.id
    json.user_name user.name
    json.total_score user.total_score
  end
end