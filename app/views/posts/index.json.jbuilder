json.posts do
  json.array!(@posts) do |post|
    json.extract! post, :id, :name, :time, :content, :priority
    json.url post_url(post, format: :json)
  end
end