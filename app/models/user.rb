class User < ApplicationRecord
  before_validation { email.downcase! }
  has_many :tasks
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password_digest, presence: true, length: { minimum: 6 }
  has_secure_password

  def taskIsOwned?(task)
    return self.id == task.user_id
  end
end
