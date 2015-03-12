class AddNameAndOrderAndTypeToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :name, :string
    add_column :posts, :priority, :integer
    add_column :posts, :type, :integer
  end
end
