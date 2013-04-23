class Track
  include MongoMapper::Document

  key :name, String

  many :artists
end
