json.posts do
  json.array!(@posts) do |post|
    json.extract! post, :id, :content, :category, :visible, :priority
    json.url post_url(post, format: :json)
  end
end
json.categories do
  json.array! ['Dieninė', 'Eisena', 'Vakarinė']
end
