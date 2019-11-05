class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true,
    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i },
    uniqueness: { case_sensitive: false }

  validates :password, confirmation: true

  validates :api_key, presence: true, uniqueness: true
end
