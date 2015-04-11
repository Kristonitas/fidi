class AddMaxAttemptsToBooths < ActiveRecord::Migration
  def change
    add_column :booths, :max_attempts, :integer, default: 0
    add_column :attempts, :entries, :integer, default: 1
  end
end
