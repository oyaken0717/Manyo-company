class Label < ApplicationRecord
  has_many :task_labels, dependent: :destroy
  has_many :task_label_tasks, through: :task_labels, source: :task
#
  def getTasks(paginate: false)
    paginate ? Kaminari.paginate_array(self.task_labels.map(&:task)) : self.task_labels.map(&:task)
  end
end
