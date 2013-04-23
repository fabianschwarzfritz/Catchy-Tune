class Track
  include MongoMapper::Document

  key :name, String
  belongs_to :artists

  attr_accessible :name, :artists
end
