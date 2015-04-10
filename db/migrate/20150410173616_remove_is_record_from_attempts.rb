class RemoveIsRecordFromAttempts < ActiveRecord::Migration
  def change
    remove_column :attempts, :is_record
  end
end
