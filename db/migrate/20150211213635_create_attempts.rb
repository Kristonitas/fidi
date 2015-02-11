class CreateAttempts < ActiveRecord::Migration
  def change
    create_table :attempts do |t|
      t.integer :user_id
      t.integer :booth_id
      t.integer :score
      t.string :comment

      t.timestamps null: false
    end
  end
end
