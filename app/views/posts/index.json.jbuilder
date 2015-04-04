json.posts do
  json.array!(@posts) do |post|
    json.extract! post, :id, :name, :content, :visible, :priority
    json.url post_url(post, format: :json)
  end
end