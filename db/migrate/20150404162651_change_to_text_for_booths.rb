class ChangeToTextForBooths < ActiveRecord::Migration
  def change
    change_column :booths, :description, :text, default: ""
  end
end
