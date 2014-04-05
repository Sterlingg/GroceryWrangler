class User < ActiveRecord::Base
  has_secure_password

  has_many :receipts, dependent: :destroy
  validates :name,  presence: true, length: {maximum: 20}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[A-Za-z\d\-.]+\.[a-zA-Z]+\z/
  validates :email, presence: true, length: {maximum: 50}, format: {with: VALID_EMAIL_REGEX}, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: {minimum: 6}
end
