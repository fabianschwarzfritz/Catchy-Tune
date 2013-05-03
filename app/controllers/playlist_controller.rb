require 'prawn'

class PlaylistController < ApplicationController

  def initialize
    @grid = Grid.new(MongoMapper.database)
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
