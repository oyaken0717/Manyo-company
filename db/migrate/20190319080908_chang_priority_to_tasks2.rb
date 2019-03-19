class ChangPriorityToTasks2 < ActiveRecord::Migration[5.2]
  def change
    # change_column :tasks, :priority, :integer, default: 0, null: false
    change_column :tasks, :priority, 'integer USING CAST(priority AS integer)', default: 0, null: false
    # change_column :table_name, :column_name, 'integer USING CAST(column_name AS integer)'
  end
end
