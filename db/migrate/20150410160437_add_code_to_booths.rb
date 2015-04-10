class AddCodeToBooths < ActiveRecord::Migration
  def change
    add_column :booths, :code, :string
  end
end
