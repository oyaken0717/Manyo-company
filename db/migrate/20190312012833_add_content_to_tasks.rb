class AddContentToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :content, :text, null:false
  end
end
