class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :user_id
      t.text :content
      t.integer :priority_id
      t.datetime :deadline
      t.integer :category

      t.timestamps null: false
    end
  end
end
