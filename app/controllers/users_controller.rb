require 'bcrypt'

class UsersController < ApplicationController

  before_filter :save_login_state, :only => [:new, :create]

  def new
    if params[:user].nil?
      @user = User.new
    else
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
end
