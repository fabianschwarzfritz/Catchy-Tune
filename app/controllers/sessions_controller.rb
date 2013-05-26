class SessionsController < ApplicationController

  before_filter :authenticate_user, :only => [:home]
  before_filter :save_login_state, :only => [:login]

  layout :get_layout

  def login
    if params.has_key? :login
      authorized_user = User.authenticate(params[:login][:username], params[:login][:password])

      if authorized_user
        session[:user_id] = authorized_user.id
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
    session[:playlist] = nil
    redirect_to :action => 'login'
  end

  private
  def get_layout
    case action_name
      when 'home'
        'home'
      else
        'application'
    end
  end
end
