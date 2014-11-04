class SessionsController < ApplicationController
  
  def new
    @user = User.new
    render :new
  end
  
  def create
    @user = User.find_by_credentials(params[:user][:name], params[:user][:email])
    if @user.nil?
      flash.now[:errors] = ['Whatchu did, not okay']
      @user = User.new
      render :new
    else
      login!
      redirect_to user_url(@user)
    end
  end
  
  def destroy
    logout!
    redirect_to users_url
  end
  
  # private
  # def session_params
  #   params.require(:session).permit(:)
  # end
end
