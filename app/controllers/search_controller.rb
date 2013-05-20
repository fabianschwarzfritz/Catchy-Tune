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

      artists = Artist.by_name_contains(@query)
      tracks = Track.by_name_contains(@query)

      @artists_count = artists.count
      @tracks_count = tracks.count

      @results = artists.to_a + tracks.to_a

      #else render page with defaults or error message
    end
  end
end
