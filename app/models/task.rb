class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  scope :search_title, -> (task_title) { where("title LIKE ?", "%#{ task_title }%") }
  scope :search_status, -> (task_status) { where(status: task_status) }

  enum priority:{"低":,"":,"":}
  enum status:{attack: 0,spells:1,defend:2,item:3, abilities:4}
end
