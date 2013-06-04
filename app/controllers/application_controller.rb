class ApplicationController < ActionController::Base
  protect_from_forgery

  def initialize
    @css_sources = Array.new
    @js_sources = Array.new

    super
  end

  protected
  def authenticate_user
    if session[:user_id]
      @current_user = User.find session[:user_id]
    else
      redirect_to(:controller => 'sessions', :action => 'login')
    end
  end

  def save_login_state
      redirect_to(:controller => 'sessions', :action => 'home') if session[:user_id]
  end
end
