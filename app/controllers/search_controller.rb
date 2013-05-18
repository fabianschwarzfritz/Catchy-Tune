class SearchController < ApplicationController

  before_filter :authenticate_user
  layout 'home'

  def results
  end

end
