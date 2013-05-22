require File.expand_path(File.join(File.dirname(__FILE__), '..', 'support', 'paths'))

module ModelHelpers

  def add_artist(artist_name)
    Artist.new({:name => artist_name}).save
  end

  def add_track(track_title, artist_name)
    artist = Artist.find_by_name(artist_name)

    if artist.nil?
      raise "No artist with name #{artist_name} found"
    else
      Track.new({:name => track_title, :artist_id => artist._id}).save
    end
  end

end

World(ModelHelpers)
