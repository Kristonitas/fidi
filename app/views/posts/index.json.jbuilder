json.posts do
  json.array!(@posts) do |post|
    json.extract! post, :id, :content, :category, :visible, :priority
    json.url post_url(post, format: :json)
  end
end

json.categories Post.categories.keys