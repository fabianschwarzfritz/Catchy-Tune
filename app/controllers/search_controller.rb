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

      @artists_count = Artist.by_name_contains(@query).count
      @tracks_count = Track.by_name_contains(@query).count

      #else render page with defaults or error message
    end
  end
end
