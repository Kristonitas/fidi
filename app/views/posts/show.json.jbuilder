json.post do
  json.extract! @post, :id, :name, :time
  json.content simple_format(@post.content)
end