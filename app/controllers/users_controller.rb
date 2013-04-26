require 'bcrypt'

class UsersController < ApplicationController

  before_filter :login_required, :only => ['welcome', 'change_password', 'hidden']

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user] = User.authenticate(@user.email, @user.password)
      flash[:message] = "You Signed up successfully"
      redirect_to :action => 'welcome'
    else
      flash[:warning] = "Signup not successful"
    end
  end

  def login
    if request.post?
      if session[:user] = User.authenticate(params[:user][:login], params[:user][:password])
        flash[:message] = "Login successful"
        redirect_to_stored
      else
        flash[:warning] = "Login unsuccessful"
      end
    end
  end

  def logout
    session[:user] = nil
    flash[:message] = 'Logged out'
    redirect_to :action => 'login'
  end

  def welcome

  end
end
