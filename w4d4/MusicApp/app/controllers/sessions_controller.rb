class SessionsController < ApplicationController

  def new
    @user = User.new
    render :new
  end
  
  def create
    @user = User.find_by_credentials(params[:user][:email], params[:user][:password])
    if @user.nil?
      @user = User.new
      render :new
    else 
      login_user!
    end
  end

  def destroy
    current_user.reset_session_token!
    self.session[:session_token] = nil

    redirect_to new_session_url
  end

end
