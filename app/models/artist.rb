class Artist
  include MongoMapper::Document

  key :name, String

  many :tracks
  belongs_to :user


  scope :by_name_contains, lambda { |name| where(:name => (/#{name}/i)) }

  self.ensure_index(:name => Mongo::ASCENDING)
  self.ensure_index(:user_id => Mongo::ASCENDING)
end
