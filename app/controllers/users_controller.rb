require 'bcrypt'

class UsersController < ApplicationController

  before_filter :forward_when_logged_in, :only => [:new]

  def new
    if params.has_key? :user
      @user = User.new(params[:user])
      @user.save

      if @user.errors.any?
        render 'new'
      else
        session[:user_id] = @user.id
        session[:redirect_origin] = Array.new
        redirect_to(:controller => 'sessions', :action => 'home')
      end
    else
      @user = User.new
    end
  end
end
