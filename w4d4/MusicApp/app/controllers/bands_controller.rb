class BandsController < ApplicationController
  
  before_action :require_signin!

  def index
    @bands = Band.all
    render :index
  end

  def new
    @band = Band.new
    render :new
  end

  def create
    @band = Band.new(band_params)

    if @band.save
      redirect_to bands_url
    else
      #@band = Band.new(band_params)
      render :new
    end
  end
  
  def edit
    @band = Band.find(params[:id])
    render :edit
  end

  def update
    @band = Band.find(params[:id])

    if @band.update(band_params)
      redirect_to band_url(@band)
    else
      render :edit
    end
  end

  def destroy
    @band = Band.find(params[:id]).destroy
    redirect_to bands_url
  end

  def show
    @band = Band.find(params[:id])
  end

  
  private
  def band_params
    params.require(:band).permit(:name)
  end
end
