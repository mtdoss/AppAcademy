class SessionsController < ApplicationController

  before_action only: [:new, :create] do 
    if current_user
      redirect_to cats_url
    end
  end
  
  def new
    @user = User.new
    render :new
  end
  
  def create
    @user = User.find_by_credentials(params[:user][:user_name], params[:user][:password])
    if @user.nil?
      render :new
    else
      login_user!
    end
  end
  
  def destroy
    current_user.reset_session_token!
    self.session[:session_token] = nil
    
    redirect_to new_session_url #sessions?
  end
  
end
#
# <input typ="text" name="user[user_name]">
#
#
# params: {user: {user_name: "shawna"}}
