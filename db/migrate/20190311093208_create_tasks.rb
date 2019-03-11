class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string "name", null: false
      t.date "deadline", null: false
      t.integer "priority", null: false
      t.string "status", null: false
      t.text "label", null: false
    end
  end
end
