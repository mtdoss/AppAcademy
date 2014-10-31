class AlbumsController < ApplicationController

  before_action :require_signin!
 def index
   @band = Band.find(params[:band_id])
   @albums = @band.albums
   render :index
 end

 def new
   @band = Band.find(params[:band_id])
   @album = Album.new(band_id: params[:band_id])
   render :new
 end

  def create
    @album = Album.new(album_params)
    if @album.save
      redirect_to album_url(@album)
    else
      flash[:errors] = @album.errors.full_messages
      @band = @album.band
      render :new
    end
  end
  
  def edit
    @band = Band.find(params[:band_id])
    @album = Album.find(params[:id])
    render :edit
  end

  def update
    @album = Album.find(params[:id])

    if @album.update(album_params)
      redirect_to band_url(@band)
    else
      render :edit
    end
  end

  def destroy
    @album = Album.find(params[:id]).destroy
    redirect_to bands_url
  end

  def show
    @album = Album.find(params[:id])
  end

  private
  def album_params
    params.require(:album).permit(:name, :band_id, :live)
  end
end
