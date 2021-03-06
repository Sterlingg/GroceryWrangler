class User < ActiveRecord::Base
  before_create :create_remember_token
  before_save { self.email = email.downcase }

  has_secure_password

  has_many :receipts, dependent: :destroy
  validates :name,  presence: true, length: {maximum: 20}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[A-Za-z\d\-.]+\.[a-zA-Z]+\z/
  validates :email, presence: true, length: {maximum: 50}, format: {with: VALID_EMAIL_REGEX}, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: {minimum: 6}

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.hash(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private
    def create_remember_token
      self.remember_token = User.hash(User.new_remember_token)
    end
end
