require 'bcrypt'

class UsersController < ApplicationController

  before_filter :save_login_state, :only => [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user.save

    if @user.errors.any?
      render 'new'
    else
      session[:user_id] = @user.id
      redirect_to(:controller => 'sessions', :action => 'home')
    end
  end
end
