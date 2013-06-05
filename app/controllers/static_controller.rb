class StaticController < ApplicationController

  before_filter :authenticate_user

  layout 'home'

  def about
  end
end
