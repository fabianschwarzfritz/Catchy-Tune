require File.expand_path(File.join(File.dirname(__FILE__), '..', 'support', 'paths'))

module ModelHelpers

  def add_artist(artist_name)
    Artist.new({:name => artist_name}).save
  end

  def add_track(track_title, artist_name, file_path = nil)
    artist = Artist.find_by_name(artist_name)

    if artist.nil?
      raise "No artist with name #{artist_name} found"
    else
      track = artist.tracks.create name: track_title

      add_file track.id.to_s, file_path unless file_path.nil?
    end
  end

  def add_file(file_id, file_path)
    file = File.open(file_path)
    gridfs = Mongo::GridFileSystem.new(MongoMapper.database)
    gridfs.open(file_id, 'w') { |f| f.write file }
  end
end

World(ModelHelpers)
