json.user! do
  json.extract! @user, :id, :name, :created_at
end

json.best_attempts do
  json.array!(@best_attempts) do |attempt|
    json.extract! attempt, :id, :score, :booth_id, :created_at
  end
end