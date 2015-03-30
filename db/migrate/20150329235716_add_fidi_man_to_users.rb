class AddFidiManToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :is_fidi, :boolean, default: false
  end
end
