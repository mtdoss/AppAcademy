class SubsController < ApplicationController
  before_action :must_be_moderator, only: [:edit, :update]
    
  def index
    @subs = Sub.all
    render :index
  end
  
  def new
    @sub = Sub.new
    render :new
  end
  
  def create
    @sub = Sub.new(sub_params)
    
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end
  
  def update
    @sub = Sub.find(params[:id])
    
    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end
  
  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end
  
  def show
    @sub = Sub.find(params[:id])
    render :show
  end
  
  private
  def sub_params
    params.require(:sub).permit(:title, :description, :user_id)
  end
  
  def must_be_moderator
    unless Sub.find(params[:id]).moderator == current_user
      redirect_to subs_url
      flash[:errors] = ['Must be moderator']
    end
  end
end






