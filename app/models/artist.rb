class Artist
  include MongoMapper::Document

  key :user_id, String
  key :name, String

  many :tracks
  belongs_to :user
end
