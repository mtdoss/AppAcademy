class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  helper_method :current_user
  def current_user
    return nil if self.session[:session_token].nil?
    @user ||= User.find_by(session_token: self.session[:session_token])
  end
  
  def login_user!
    @user.reset_session_token!
    self.session[:session_token] = @user.session_token

    redirect_to users_url
  end

  def log_out!
    self.session[:session_token] = nil
  end

  def require_signin!
    redirect_to new_session_url if current_user.nil?
  end
end
