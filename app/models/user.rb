class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true
  validates :password_digest, presence: true
  validates :password, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }
end
