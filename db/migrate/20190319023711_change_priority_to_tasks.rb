class ChangePriorityToTasks < ActiveRecord::Migration[5.2]
  def up
    # add_column :tasks, :priority, :string
    change_table :tasks do |t|
      t.change :priority, :string
    end
  end

  def down
    # remove_column :tasks, :priority, :integer
    change_table :tasks do |t|
      t.change :priority, :integer
    end
  end
end
