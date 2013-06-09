class SessionsController < ApplicationController

  before_filter :authenticate_user, :only => [:home]
  before_filter :forward_when_logged_in, :only => [:login]

  layout :get_layout

  def login
    if params.has_key? :login
      authorized_user = User.authenticate(params[:login][:username], params[:login][:password])

      if authorized_user
        session[:user_id] = authorized_user.id
        session[:redirect_origin] = Array.new
        redirect_to(:action => 'home')
      else
        flash[:notice] = 'Invalid Username or Password'
        flash[:color]= 'invalid'
        render 'login'
      end
    end
  end

  def logout
    session[:user_id] = nil
    session.delete(:redirect_origin)
    redirect_to :action => 'login'
  end

  private
  def get_layout
    case action_name
      when 'home'
        'home'
      else
        'login'
    end
  end
end
