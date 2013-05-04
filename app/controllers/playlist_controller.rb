require 'prawn'
require 'mongo'

class PlaylistController < ApplicationController

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


  private
  def getsong(id)
    @grid.get(BSON::ObjectId(id))
  end
end
