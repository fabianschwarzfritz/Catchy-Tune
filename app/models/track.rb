class Track
  include MongoMapper::Document

  key :artist_id, ObjectId
  key :name, String

  belongs_to :artist

  scope :by_name_contains, lambda { |name| where(:name => (/#{name}/i)) }
end
