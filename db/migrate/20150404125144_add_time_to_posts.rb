class AddTimeToPosts < ActiveRecord::Migration
  def change
  	add_column :posts, :time, :string, default: '9:99'
  end
end
