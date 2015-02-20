json.map do
  json.array!(@booths) do |booth|
    json.extract! booth, :id, :name, :description, :image_url, :pos_x, :pos_y
  end
end