class Artist
  include MongoMapper::Document

  key :name, String

  many :tracks
end
