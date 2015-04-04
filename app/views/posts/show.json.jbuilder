json.post do
  json.extract! @post, :id, :name, :time, :content
end