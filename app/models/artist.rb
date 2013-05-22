class Artist
  include MongoMapper::Document

  key :user_id, String
  key :name, String

  many :tracks
  belongs_to :user


  scope :by_name_contains, lambda { |name| where(:name => (/#{name}/i)) }

  self.ensure_index(:name => Mongo::ASCENDING)
end
