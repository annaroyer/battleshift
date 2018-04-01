class User < ApplicationRecord
  has_secure_password
  validates_confirmation_of :password, on: :create
  validates_presence_of :password_confirmation, on: :create
  validates :password, presence: true, on: :update, allow_blank: true
  validates :name, :email, presence: true, uniqueness: true

  enum status: %w(inactive active)

  before_create do
    self.api_key = SecureRandom.base64
  end

end
