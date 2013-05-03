require 'prawn'

class PlaylistController < ApplicationController

  def initialize
    @grid = Grid.new(MongoMapper.database)
    @fs = GridFileSystem.new(Mongomapper.database)
  end

  def stream
    id = params[:songid]
    send_data getsong(id), :filename => "#{id}", :type => "audio/mpeg"
  end

  def upload
    songid = params[:id]
    file = IO.read(params[:upload][:file])
    storesong(id)
  end

  private
  def getsong(id)
    @grid.get(params[:file])
  end

  def storesong(id)
    @fs.put(file, :filename => "songid")
  end
end
