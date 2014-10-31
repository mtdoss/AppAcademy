class TracksController < ApplicationController

  before_action :require_signin!
  def index
    @album = Album.find(params[:album_id])
    @tracks = @album.tracks
    render :index
  end

  def new
    @album = Album.find(params[:album_id])
    @track = Track.new(album_id: params[:album_id])
    render :new
  end

  def create
    @track = Track.new(track_params)
    if @track.save
      redirect_to track_url(@track)
    else
      @album = @track.album
      render :new
    end
  end

  # def edit
  #   @band = Band.find(params[:band_id])
  #   @album = Album.find(params[:id])
  #   render :edit
  # end

  # def update
  #   @album = Album.find(params[:id])

  #   if @album.update(album_params)
  #     redirect_to band_url(@band)
  #   else
  #     render :edit
  #   end
  # end

  # def destroy
  #   @album = Album.find(params[:id]).destroy
  #   redirect_to bands_url
  # end

  def show
    @track = Track.find(params[:id])
  end

  
  private
  def track_params
    params.require(:track).permit(:name, :lyrics, :bonus, :album_id)
  end
  
end
