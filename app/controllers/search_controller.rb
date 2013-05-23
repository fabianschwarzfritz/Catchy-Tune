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

      artists = Artist.by_name_contains(@query).all
      tracks = Track.by_name_contains(@query).all

      @artists_count = artists.length
      @tracks_count = tracks.length

      @results = artists + tracks

      # prefetch artist information for tracks
      if @tracks_count > 0
        @track_artists = Hash.new

        # collect distinct artist ids from tracks
        track_artists = (tracks.collect { |track| track.artist_id }).uniq
        # get all corresponding artists from database
        track_artists = Artist.where(:_id => track_artists).all
        # convert the artists array to a hash for easier access
        track_artists.each { |artist| @track_artists[artist._id] = artist }
      end

      #else render page with defaults or error message
    end
  end
end
