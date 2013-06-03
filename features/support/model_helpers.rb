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

      add_file(track.id, file_path) unless file_path.nil?
    end
  end

  def add_file(filename, file_path)
    file = File.open(file_path)

    types = MIME::Types.type_for(file_path)
    if types.nil? || types.empty?
      content_type = nil
    else
      content_type = types.first.simplified
    end

    grid = Mongo::Grid.new(MongoMapper.database)
    grid.put(file, :filename => filename, :content_type => content_type)
  end
end

World(ModelHelpers)
