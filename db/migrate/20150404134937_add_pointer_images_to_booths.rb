class AddPointerImagesToBooths < ActiveRecord::Migration
  def change
    add_column :booths, :pointer_image_url, :string, default: ""
  end
end
