class User < ActiveRecord::Base

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
=begin
  has_secure_password takes care of:
    checking that password and password_confirmation match
    validates presence of password on creation
    provides with an authenticate method.
=end
  has_secure_password
  attr_reader :remember_token

  before_save { email.downcase! }

  validates :password, length: { minimum: 6, maximum: 50 }
  validates :firstname, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  validates :login, presence: true, uniqueness: { case_sensitive: false }
  def name
    firstname+" "+lastname
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
end
