class AddDefaultVisibleToPosts < ActiveRecord::Migration
  def change
    change_column :posts, :visible, :boolean, default: true
  end
end
