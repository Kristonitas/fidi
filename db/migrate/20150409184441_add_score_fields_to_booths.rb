class AddScoreFieldsToBooths < ActiveRecord::Migration
  def change
    add_column :booths, :multi, :integer, default: 100
    add_column :booths, :userable, :boolean, default: false
    add_column :booths, :min_score, :integer
    add_column :booths, :max_score, :integer
    add_column :booths, :available_scores, :integer, :array => true
  end
end
