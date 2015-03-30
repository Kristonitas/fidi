class AddIsRecordToAttempts < ActiveRecord::Migration
  def change
    add_column :attempts, :is_record, :boolean, default: false
  end
end
