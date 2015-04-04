json.post do
  json.extract! @post, :id, :content, :visible
end