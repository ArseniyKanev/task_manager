class User < ActiveRecord::Base

  has_secure_password

  has_many :tasks, dependent: :destroy

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :role, presence: true
  validates :password, presence: true, length: { minimum: 8 }, allow_nil: true
  validates :password_confirmation, presence: true, allow_nil: true

  enum role: {admin: 0, user: 1}

end
