class User < ActiveRecord::Base
  validates :name,  presence: true, length: {maximum: 20}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[A-Za-z\d\-.]+\.[a-zA-Z]+\z/
  validates :email, presence: true, length: {maximum: 50}, format: {with: VALID_EMAIL_REGEX}
end
