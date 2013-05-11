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
    puts "current playlist: " << session[:playlist].inspect
    id = params[:songid]
    playlist = session[:playlist]
    playlist << id
    session[:playlist] = playlist
    puts "current playlist: " << session[:playlist].inspect
    render :nothing => true
  end

  def current_song
    puts "current playlist: " << session[:playlist].inspect
    @current_song_id = session[:playlist][0]
    puts "current song: " << @current_song_id
    puts "current playlist: " << session[:playlist].inspect
    puts @current_song_id
    respond_to do |format|
      format.text { render :text => @current_song_id }
    end
  end

  def next
    session[:playlist].shift()
    puts "current playlist: " << session[:playlist].inspect
    render :nothing => true
  end

  private
  def getsong(id)
    @grid.get(BSON::ObjectId(id))
  end

  def prepare_session
    puts "before playlist: " << session[:playlist].inspect
    playlist = session[:playlist]
    if playlist.nil?
      playlist ||= Array.new
    end
    session[:playlist] = playlist
    puts "after playlist: " << session[:playlist].inspect
  end
end
