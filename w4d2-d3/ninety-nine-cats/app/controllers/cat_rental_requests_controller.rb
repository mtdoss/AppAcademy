class CatRentalRequestsController < ApplicationController
  def index
    @crr = CatRentalRequest.all
    render :index
  end
  
  def new
    @crr = CatRentalRequest.new
    render :new
  end
  
  def create
    @crr = CatRentalRequest.new(crr_params)
    @crr.user_id = current_user.id
    @cat = Cat.find(@crr.cat_id)
    if @crr.save
      redirect_to cat_url(@cat)
    else
      render :new
    end
  end
  
  def approve
    @crr = CatRentalRequest.find(params[:id])
    @crr.approve!
  end
  
  def deny
    @crr = CatRentalRequest.find(params[:id])
    @crr.deny!
  end
  
  
  private
    def crr_params
      params[:crr].
        permit(:cat_id, :status, :start_date, :end_date, :id)
    end
  
  
end
