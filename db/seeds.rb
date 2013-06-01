# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

100.times do |artistnumber|
  a = Artist.create name: Faker::Name.name
  10.times do |tracknumber|
    a.tracks.create name: Faker::Lorem.words(rand(10)+1).join(' ') << tracknumber
  end
end

# Stores an example as file and to tracks colleciton
def store(artist, songname, file)
  track = artist.tracks.create name: songname

  @file = File.open(file)
  @grid = Mongo::GridFileSystem.new(MongoMapper.database)
  @grid.open(track.id, 'w', :content_type => 'audio/mpeg') do |f|
    f.write @file
  end
end

leftlanecruiser = Artist.create name: "Left Lane Cruiser"
atribecalledred = Artist.create name: "A Tribe Called Red"

store(leftlanecruiser, 'Hillgrass Bluebilly', 'exampledata/song.mp3')
store(atribecalledred, 'Electric Pow Wow', 'exampledata/song2.mp3')