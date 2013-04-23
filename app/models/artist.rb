class Artist
  include MongoMapper::Document

  key :name, String
  many :tracks

  attr_accessible :name
end
