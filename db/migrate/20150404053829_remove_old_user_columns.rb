class RemoveOldUserColumns < ActiveRecord::Migration
  def change
  	remove_column :users, :booth_id
  	remove_column :users, :is_fidi
  end
end
