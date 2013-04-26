require 'bcrypt'

class User
  include MongoMapper::Document

  attr_accessible :email, :password, :password_confirmation
  #EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+.[A-Z]{2,4}$/i

  key :email, String
  key :password, String
  key :hashed_password, String
  key :salt, String

  before_save :encrypt_password
  after_save :clear_password
  validates :email,
            :presence => true,
            :uniqueness => true,
            :length => {:in => 3..40}
  validates :password,
            :presence => true,
            :length => {:minimum => 5, :maximum => 40},
            :confirmation => true
  validates_confirmation_of :password

  def encrypt_password
    if password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.hashed_password = BCrypt::Engine.hash_secret(password, salt)
    end
  end

  def clear_password
    self.password = nil
  end

  def self.authenticate(username_or_email="", login_password="")
    user = User.find_by_email(username_or_email)

    if user && user.match_password(login_password)
      return user
    else
      return false
    end
  end

  def match_password(login_password="")
    hashed_password == BCrypt::Engine.hash_secret(login_password, salt)
  end
end
