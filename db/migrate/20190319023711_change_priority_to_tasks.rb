class ChangePriorityToTasks < ActiveRecord::Migration[5.2]
  def up
    change_table :tasks do |t|
      # t.change :priority, :string
      t.change :priority, :integer
      t.integer :priority,default: 0, null: false
    end
  end

  def down
    change_table :tasks do |t|
      # t.change :priority, :integer
      t.change :priority, :string
    end
  end
end
