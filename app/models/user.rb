class User < ApplicationRecord
  include BCrypt

  has_secure_password

  has_one_attached :avatar

  has_many :uploads

  validates :email_address, presence: true, uniqueness: true
  validates :password, presence: true
  validates :password_confirmation, presence: true
  validates :avatar, presence: true
end
