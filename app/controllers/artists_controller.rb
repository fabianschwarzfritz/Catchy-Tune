class ArtistsController < ApplicationController

  before_filter :authenticate_user
  before_filter :prevent_second_artist_for_user, :only => [:new, :create]
  before_filter :allow_only_artist_user, :only => [:edit, :update, :destroy]
  layout 'home'

  # GET /artists
  # GET /artists.json
  def index
    @artists = Artist.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @artists }
    end
  end

  # GET /artists/1
  # GET /artists/1.json
  def show
    @artist = Artist.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @artist }
    end
  end

  # GET /artists/new
  # GET /artists/new.json
  def new
    @artist = Artist.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @artist }
    end
  end

  # GET /artists/1/edit
  def edit
    @artist = Artist.find(params[:id])
  end

  # POST /artists
  # POST /artists.json
  def create
    @artist = Artist.new(params[:artist])
    @artist.user = @current_user

    respond_to do |format|
      if @artist.save
        format.html { redirect_to session[:redirect_origin].pop || @artist, notice: 'Artist was successfully created.' }
        format.json { render json: @artist, status: :created, location: @artist }
      else
        format.html { render action: "new" }
        format.json { render json: @artist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /artists/1
  # PUT /artists/1.json
  def update
    @artist = Artist.find(params[:id])

    respond_to do |format|
      if @artist.update_attributes(params[:artist])
        format.html { redirect_to @artist, notice: 'Artist was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @artist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /artists/1
  # DELETE /artists/1.json
  def destroy
    @artist = Artist.find(params[:id])
    @artist.destroy

    respond_to do |format|
      format.html { redirect_to artists_url }
      format.json { head :no_content }
    end
  end


  private
  def allow_only_artist_user
    @artist = Artist.find(params[:id])

    redirect_to(:action => :show) unless @artist.user == @current_user
  end

  def prevent_second_artist_for_user
    redirect_to(edit_artist_path(@current_user.artist.id)) unless @current_user.artist.nil?
  end
end
