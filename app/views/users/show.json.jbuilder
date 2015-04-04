json.user do
  json.extract! @user, :id, :name, :first_name, :last_name, :qr_link, :google_qr_link, :total_score
end

json.best_attempts do
  json.array!(@best_attempts) do |attempt|
    json.extract! attempt, :id, :score, :booth_id, :created_at
  end
end