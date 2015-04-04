json.post do
  json.extract! @post, :id, :content, :visible, :created_at, :updated_at, :category
end

json.categories Post.categories.keys