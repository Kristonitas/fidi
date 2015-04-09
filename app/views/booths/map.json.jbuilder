json.map do
  json.array!(@booths) do |booth|
    json.extract! booth, :id, :name, :description, :image_url, :pointer_image_url, :pos_x, :pos_y
    if @booths_visited
    	json.visited @booths_visited.include?(booth.id)
    end
  end
end