class Track
  include MongoMapper::Document

  key :artist_id, ObjectId
  key :name, String

  belongs_to :artist


  self.ensure_index(:artist_id => Mongo::ASCENDING)
  self.ensure_index(:name => Mongo::ASCENDING)
end
