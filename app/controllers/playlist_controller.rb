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
    if not id.empty?
      begin
        song = getsong(id)
        send_data song.read, :filename => "#{id}", :type => "audio/mpeg"
      rescue Mongo::GridFileNotFound
        puts "Could not find song with id #{id} in database!"
      end
    end
  end

  def add
    id = params[:songid]
    session[:playlist] << id if id != nil
    render :nothing => true
  end

  def current_song
    @current_song_id = get_current_song_id()
    puts session[:playlist]
    respond_to do |format|
      format.text { render :text => @current_song_id }
    end
  end

  def next
    session[:playlist].shift()
    puts session[:playlist].inspect
    render :nothing => true
  end

  def showcurrentsong
    current_song_id = get_current_song_id()
    @track = Track.find(current_song_id)
    render :partial => "playlist/showcurrentsong"
  end

  private
  def getsong(id)
    song = @fs.exist? :filename => BSON::ObjectId(id)
    @grid.get(song['_id'])
  end

  def prepare_session
    session[:playlist] ||= Array.new
  end

  def get_current_song_id()
    return session[:playlist].first
  end
end
