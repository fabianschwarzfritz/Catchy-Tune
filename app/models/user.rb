require 'bcrypt'

class User
  include MongoMapper::Document

  key :username, String
  key :hashed_password, String
  key :salt, String

  belongs_to :artist


  before_save :encrypt_password, :clear_password

  validates :username,
            :presence => true,
            :uniqueness => true,
            :length => {:in => 3..40}
  validates :password,
            :presence => true,
            :length => {:minimum => 5, :maximum => 40},
            :confirmation => true


  def is_artist
    return Artist.find(:user => id)
  end

  def match_password(login_password='')
    hashed_password == BCrypt::Engine.hash_secret(login_password, salt)
  end

  def self.authenticate(username='', login_password='')
    user = User.find_by_username(username)

    if user && user.match_password(login_password)
      return user
    else
      return false
    end
  end

  def self.find_by_username(username)
    User.first(:username => username)
  end

  private

  def encrypt_password
    if password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.hashed_password = BCrypt::Engine.hash_secret(password, salt)
    end
  end

  def clear_password
    self.password = nil
  end


  self.ensure_index({:username => Mongo::ASCENDING}, :unique => true)
end
