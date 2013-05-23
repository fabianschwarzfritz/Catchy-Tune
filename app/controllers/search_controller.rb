class SearchController < ApplicationController

  before_filter :authenticate_user
  layout 'home'

  def initialize
    @query = '<<no query>>'
    @artists_count = @tracks_count = 0

    # Invoke initialize in superclass, so rails can do its initialization.
    # Otherwise, essential functionality (such as layouts) would not work.
    super
  end

  def results
    if params[:search]
      @query = params[:search][:query]

      artists_h = search_artist @query

      tracks = search_track(@query, artists_h)

      @artists_count = artists_h.length
      @tracks_count = tracks.length

      # prefetch artist information for tracks
      if @tracks_count > 0
        # collect distinct artist ids from tracks
        track_artists = (tracks.collect { |track| track.artist_id }).uniq
        # query #4: find all tracks' artist
        # get all corresponding artists from database
        track_artists = Artist.where(:_id => track_artists).to_a
        # convert the artists array to a hash for easier access
        track_artists_h = Hash.new
        track_artists.each { |artist| track_artists_h[artist._id] = artist }

        tracks.each do |track|
          track.extend SearchHelper::TrackExtensions

          track.artist_tmp = track_artists_h[track.artist_id]
        end
      end

      @results = artists_h.values + tracks

      #else render page with defaults or error message
    end
  end


  private

  def search_artist(query)
    artists_h = Hash.new

    # query #1: find all artists
    # search for artists and store them in a hash with key document id
    Artist.by_name_contains(query).each do |artist|
      artist.extend SearchHelper::ArtistExtensions

      artists_h[artist._id] = artist
    end

    # query #2: find all artists' tracks
    # get track information for all found artists and map them onto their artists afterwards
    Track.where(:artist_id => artists_h.keys).each do |track|
      artists_h[track.artist_id].tracks_tmp << track
    end unless artists_h.empty?

    artists_h
  end

  def search_track(query, artists_h = Hash.new)
    # query #3: find all tracks
    # search for tracks, except for those which were already found with their artist (in query #2)
    tracks = Track.by_name_contains(query)
    tracks = tracks.where(:_id => {'$not' => {'$in' => artists_h.keys}}) unless artists_h.empty?

    tracks.all
  end

end
