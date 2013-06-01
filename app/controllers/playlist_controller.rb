require 'prawn'
require 'mongo'

class PlaylistController < ApplicationController

  before_filter :prepare_session

  def initialize
    @fs = Mongo::GridFileSystem.new(MongoMapper.database)
    @grid = Mongo::Grid.new(MongoMapper.database)

    # Invoke initialize in superclass, so rails can do its initialization.
    # Otherwise, essential functionality (such as layouts) would not work.
    super
  end

  def stream
    id = params[:track_id]
    unless id.nil? or id.empty?
      begin
        song = get_song BSON::ObjectId.from_string id
        send_data song[:content].read, :filename => song[:filename], :type => song[:content_type]
      rescue Mongo::GridFileNotFound
        puts "Could not find song with id #{id} in database!"
      end
    end
  end

  def add
    if params.has_key? :track_id
      id = params[:track_id]
      session[:playlist] << id unless id.nil?
    end

    if params.has_key? :artist_id
      id = params[:artist_id]
      Track.find_all_by_artist_id(id).each { |track| session[:playlist] << track._id }
    end

    render :nothing => true
  end

  def current_song
    current_song_id = session[:playlist].first

    respond_to do |format|
      format.text { render :text => current_song_id }
      format.html { render :partial => 'current_song', :locals => {:track => Track.find(current_song_id)} }
    end
  end

  def next
    session[:playlist].shift()
    render :nothing => true
  end

  private
  def get_song(id)
    file = @grid.exist? :filename => id

    if file
      file = file.symbolize_keys
      file[:content] = @grid.get(file[:_id])
      file
    else
      raise Mongo::GridFileNotFound
    end
  end

  def prepare_session
    session[:playlist] ||= Array.new
  end
end
