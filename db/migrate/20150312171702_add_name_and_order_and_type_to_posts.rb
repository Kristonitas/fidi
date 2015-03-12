class AddNameAndOrderAndTypeToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :name, :string
    add_column :posts, :priority, :integer, default: 0
    add_column :posts, :type, :integer, default: 0
  end
end
