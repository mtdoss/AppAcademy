class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  def current_user
   return nil if self.session[:session_token].nil?
   @user ||= User.find_by(session_token: self.session[:session_token])
  end
 helper_method :current_user

 def login_user!
   @user.reset_session_token!
   self.session[:session_token] = @user.session_token
   redirect_to cats_url
 end


end


