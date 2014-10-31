class CatsController < ApplicationController

  before_action except: [:index] do
    unless current_user
      redirect_to new_session_url
    end
  end
  
    
  before_action only: [:edit, :update] do
    @cat = Cat.find(params[:id])

    unless @cat.user_id == current_user.id
      redirect_to cats_url
    end
  end
  

  
  def index
    @cats = Cat.all
    render :index
  end
  
  def show
    @cat = Cat.find(params[:id])
    render :show
  end
  
  def new
    @cat = Cat.new
    render :new
  end
  
  def create
    @cat = Cat.new(cat_params)
    @cat.user_id = current_user.id
    if @cat.save
      redirect_to cat_url(@cat)
    else
      render :new
      # render json: @cat.errors.full_messages, status: :unproccesable_entity
    end
  end
  
  def update
    @cat = Cat.find(params[:id])
    if @cat.update(cat_params)
      redirect_to cat_url(@cat)
    else
      render :edit
    end
  end
  
  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end
  
  
  
  private
  def cat_params
    params[:cat].permit(:name, :color, :sex, :description, :birth_date, :id, :user_id)
  end
end
