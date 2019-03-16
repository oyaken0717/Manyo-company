class ChangeColumnToTask < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :name, :string, null: false
    change_column :tasks, :deadline, :date, null: false
    change_column :tasks, :priority, :integer, null: false
    change_column :tasks, :status, :string, default: "未着手"
    change_column :tasks, :content, :text, null: false
  end
end
