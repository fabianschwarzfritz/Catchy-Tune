require 'bcrypt'

class User
  include MongoMapper::Document

  attr_accessible :email, :password, :password_confirmation

  key :email, String
  key :password, String

  before_save :hash_password
  validates :email,
            :presence => true,
            :uniqueness => true
  validates :password,
            :presence => true,
            :length => {:minimum => 5, :maximum => 40},
            :confirmation => true
  validates_confirmation_of :password

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
