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

      artists_h = Hash.new
      Artist.by_name_contains(@query).all.each do |artist|
        artist.extend SearchHelper::ArtistExtensions

        artists_h[artist._id] = artist
      end

      @artists_count = artists_h.length

      # prefetch track information for artists
      Track.where(:artist_id => artists_h.keys).all.each { |track| artists_h[track.artist_id].tracks_tmp << track } if @artists_count > 0


      tracks = Track.by_name_contains(@query).all.reject { |track| artists_h.has_key? track.artist_id }

      @tracks_count = tracks.length

      # prefetch artist information for tracks
      if @tracks_count > 0
        track_artists_h = Hash.new

        # collect distinct artist ids from tracks
        track_artists = (tracks.collect { |track| track.artist_id }).uniq
        # get all corresponding artists from database
        track_artists = Artist.where(:_id => track_artists).all
        # convert the artists array to a hash for easier access
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
end
