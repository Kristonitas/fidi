class AddBoothRelationToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :booth_id, :integer
  end
end
