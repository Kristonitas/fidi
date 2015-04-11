class AddVisibilityToBooths < ActiveRecord::Migration
  def change
    add_column :booths, :visible, :boolean, default: true
  end
end
