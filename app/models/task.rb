class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  scope :search_title, -> (task_title) { where("title LIKE ?", "%#{ task_title }%") }
  scope :search_status, -> (task_status) { where(status: task_status) }
  # scope :search_title, -> { where("title LIKE ?", "%#{ task_params[:title] }%") }

end
