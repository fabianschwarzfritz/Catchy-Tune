class ApplicationController < ActionController::Base
  protect_from_forgery

  def initialize
    @css_sources = Array.new
    @js_sources = Array.new

    super
  end

  protected
  def authenticate_user
    redirect_to(:controller => 'sessions', :action => 'login') if current_user(session[:user_id]).nil?
  end

  def forward_when_logged_in
    redirect_to(:controller => 'sessions', :action => 'home') unless current_user(session[:user_id]).nil?
  end

  private
  def current_user(user_id = nil)
    @current_user = User.find(user_id) unless user_id.nil?
  end
end
