class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :deadline, presence: true
  scope :search_title, -> (task_title) { where("title LIKE ?", "%#{ task_title }%") }
  scope :search_status, -> (task_status) { where(status: task_status) }
  scope :search_label, -> (task_label) { where("label LIKE ?", "%#{ task_label }%") }
  enum priority:{"低":0,"中":1,"高":2}
  belongs_to :user
  has_many :task_labels, dependent: :destroy
  has_many :labels, through: :task_labels, source: :label
  # has_many :task_label_tasks, through: :task_labels, source: :label
end

# task.user
# tasks.task_labels.each do |taks_label|
#   task_label.label
# end
#
# tasks.task_labels.map do |taks_label|
#   task_label.label
# end
#  ==
#  task.labels
