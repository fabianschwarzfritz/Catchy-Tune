class Track
  include MongoMapper::Document

  key :artist_id, ObjectId
  key :name, String

  belongs_to :artist
end
