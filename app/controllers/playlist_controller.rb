require 'prawn'
require 'mongo'

class PlaylistController < ApplicationController

  before_filter :prepare_session

  def initialize
    @fs = Mongo::GridFileSystem.new(MongoMapper.database)
    @grid = Mongo::Grid.new(MongoMapper.database)
  end

  def stream
    id = params[:songid]
    begin
      song = getsong(id)
      send_data song.read, :filename => "#{id}", :type => "audio/mpeg"
    rescue Mongo::GridFileNotFound
      puts "Could not find song with id #{id} in database!"
    end
  end

  def add
    id = params[:songid]
    session[:playlist] << id if id != nil
    render :nothing => true
  end

  def current_song
    @current_song_id = get_current_song_id()
    respond_to do |format|
      format.text { render :text => @current_song_id }
    end
  end

  def next
    session[:playlist].shift()
    puts session[:playlist].inspect
    render :nothing => true
  end

  private
  def getsong(id)
    @grid.get(BSON::ObjectId(id))
  end

  def prepare_session
    session[:playlist] ||= Array.new
  end

  def get_current_song_id()
    return session[:playlist].first
  end
end
