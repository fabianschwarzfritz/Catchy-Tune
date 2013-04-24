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