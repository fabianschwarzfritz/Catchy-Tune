require 'bcrypt'

class User
  include MongoMapper::Document

  before_save :hash_password

  key :email, String
  key :password, String
  attr_accessible :email, :password

  private
  def hash_password
    self.password = BCrypt::Password.create(@password)
  end

  public
  def self.authenticate(email, password)
    if user = find_by_email(email)
      if BCrypt::Password.new(user.hashed_password).is_password? password
        return user
      end
    end
    return nil
  end
end
