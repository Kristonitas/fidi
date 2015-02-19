class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :content
      t.boolean :visible

      t.timestamps null: false
    end
  end
end
