json.array!(@posts) do |post|
  json.extract! post, :id, :content, :visible
  json.url post_url(post, format: :json)
end
