class TracksController < ApplicationController

  before_filter :authenticate_user
  before_filter :verify_user_is_artist, :only => [:new, :create]
  layout 'home'

  def initialize
    @grid = Mongo::Grid.new(MongoMapper.database)

    super
  end

  # GET /tracks
  # GET /tracks.json
  def index
    @tracks = Track.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tracks }
    end
  end

  # GET /tracks/1
  # GET /tracks/1.json
  def show
    @track = Track.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @track }
    end
  end

  # GET /tracks/new
  # GET /tracks/new.json
  def new
    @track = Track.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @track }
    end
  end

  # GET /tracks/1/edit
  def edit
    @track = Track.find(params[:id])
  end

  # POST /tracks
  # POST /tracks.json
  def create
    params[:track].extend TracksHelper::ParamsExtensions
    @track = Track.new(params[:track].entity_params)
    @track.artist = @current_user.artist

    update_file(params[:track][:file], @track.id)

    respond_to do |format|
      if @track.save
        format.html { redirect_to @track, notice: 'Track was successfully created.' }
        format.json { render json: @track, status: :created, location: @track }
      else
        delete_file @track.id
        format.html { render action: "new" }
        format.json { render json: @track.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tracks/1
  # PUT /tracks/1.json
  def update
    params[:track].extend TracksHelper::ParamsExtensions
    @track = Track.find(params[:id])

    respond_to do |format|
      if @track.update_attributes(params[:track].entity_params)
        update_file(params[:track][:file], @track.id)

        format.html { redirect_to @track, notice: 'Track was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @track.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tracks/1
  # DELETE /tracks/1.json
  def destroy
    @track = Track.find(params[:id])
    @track.destroy

    delete_file @track.id

    respond_to do |format|
      format.html { redirect_to tracks_url }
      format.json { head :no_content }
    end
  end

  private
  def verify_user_is_artist
    redirect_to(:controller => :artists, :action => :new) if @current_user.artist.nil?
  end

  def update_file(file, track_id)
    delete_file track_id

    unless file.nil?
      file_content = file.read
      store_file file_content, track_id, file.content_type
    end
  end

  def store_file(file, id, content_type=nil)
    @grid.put(file, :filename => id, :content_type => content_type)
  end

  def delete_file(name)
    file = @grid.exist? :filename => name
    @grid.delete file['_id'] if file
  end
end
