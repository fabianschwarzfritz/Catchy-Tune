class SessionsController < ApplicationController

  before_filter :authenticate_user, :only => [:home]
  before_filter :save_login_state, :only => [:login, :login_attempt]

  def login
#Login Form
  end

  def logout
    session[:user_id] = nil
    redirect_to :action => 'login'
  end

  def login_attempt
    authorized_user = User.authenticate(params[:email], params[:login_password])
    puts "You are @{ authorized_user} authenticated"
    if authorized_user
      session[:user_id] = authorized_user.id
      flash[:notice] = "Wow Welcome again, you logged in as #{authorized_user.email}"
      redirect_to(:action => 'home')
    else
      flash[:notice] = "Invalid Username or Password"
      flash[:color]= "invalid"
      render "login"
    end
  end
end
