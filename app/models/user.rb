class User < ApplicationRecord
  before_save { self.email = email.downcase }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  has_secure_password

  has_many :conversations
  has_many :messages

  validates :name,  presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 100 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 8 }, allow_nil: true

  def self.sign_in_using_omniauth(auth)
    find_by(provider: auth['provider'], email: auth['info']['email']) ||
    create_user_using_omniauth(auth)
  end

  def self.create_user_using_omniauth(auth)
    create(
      provider: auth['provider'],
      name: auth['info']['name'],
      email: auth['info']['email'],
      password: BCrypt::Password.create('password')
    )
  end
end
