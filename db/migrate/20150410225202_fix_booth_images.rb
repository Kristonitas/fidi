class FixBoothImages < ActiveRecord::Migration
  def change
  	rename_column :booths, :image_url, :popup_image
  	rename_column :booths, :pointer_image_url, :pointer_image
  end
end
