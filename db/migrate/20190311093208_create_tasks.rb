class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string "name"
      t.date "deadline"
      t.integer "priority"
      t.string "status"
      t.text "label"
    end
  end
end
