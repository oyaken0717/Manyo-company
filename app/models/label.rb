class Label < ApplicationRecord
  has_many :task_label, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
  has_many :task_label_tasks, through: :task_label, source: :task
end
