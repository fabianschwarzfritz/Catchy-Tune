require 'prawn'
require 'mongo'

class PlaylistController < ApplicationController

  def initialize
    @fs = Mongo::GridFileSystem.new(MongoMapper.database)
    @grid = Mongo::Grid.new(MongoMapper.database)
  end

  def stream
    id = params[:songid]
    send_data getsong(id), :filename => "#{id}", :type => "audio/mpeg"
  end



  private
  def getsong(id)
    @grid.get(params[:file])
  end
end
