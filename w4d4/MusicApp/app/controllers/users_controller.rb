class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login_user!
    else
      render :new
    end
  end

  def destroy

  end

  def show
    if self.current_user.nil?
      redirect_to new_session_url
    else
      @user = self.current_user
      render :show
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end

end
