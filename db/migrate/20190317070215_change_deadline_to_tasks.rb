class ChangeDeadlineToTasks < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :deadline, :date, null: false
  end
end
