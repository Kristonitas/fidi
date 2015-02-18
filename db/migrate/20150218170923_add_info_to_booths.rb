class AddInfoToBooths < ActiveRecord::Migration
  def change
    add_column :booths, :image_url, :string
    add_column :booths, :x, :integer, null: false
    add_column :booths, :y, :integer, null: false
  end
end
