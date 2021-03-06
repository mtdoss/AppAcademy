class UsersController < ApplicationController
  
  before_action only: [:create, :new] do 
    if current_user
      redirect_to cats_url
    end
  end
  
  def new
    @user = User.new
    render :new
  end
  
  def index
    @users = User.all
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      login_user!
    else
      render :new
    end
    
  end

  private
  def user_params
    params.require(:user).permit(:user_name, :password)
  end

end
