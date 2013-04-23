class User
  include MongoMapper::Document

  key :email, String
  key :password, String

  attr_accessible :email, :password
end
