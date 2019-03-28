class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  scope :search_title, -> (task_title) { where("title LIKE ?", "%#{ task_title }%") }
  scope :search_status, -> (task_status) { where(status: task_status) }
  enum priority:{"低":0,"中":1,"高":2}
  belongs_to :user
  has_many :task_label, dependent: :destroy
end
