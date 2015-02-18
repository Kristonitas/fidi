class AddInfoToBooths < ActiveRecord::Migration
  def change
    add_column :booths, :image_url, :string, default: ""
    add_column :booths, :pos_x, :integer, default: 0
    add_column :booths, :pos_y, :integer, default: 0
  end
end
