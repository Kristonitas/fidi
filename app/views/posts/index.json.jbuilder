json.posts do
  json.array!(@posts) do |post|
    json.extract! post, :id, :name, :time, :priority
  	json.content simple_format(post.content)
    json.url post_url(post, format: :json)
  end
end