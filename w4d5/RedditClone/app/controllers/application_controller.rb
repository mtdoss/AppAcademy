class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  
  def current_user #class method?
    return nil unless self.session[:session_token]
    @current_user ||= User.find_by_session_token(session[:session_token])
    # @user = User.find_by_session_token(session[:session_token])
    # return nil if @user.nil?
  end
  
  def login!
    @user.reset_session_token!
    self.session[:session_token] = @user.session_token
  end
  
  def self.logged_in?
    !current_user.nil? #current_user.present?
  end
  
  def logout!
    current_user.reset_session_token!
    self.session[:session_token] = nil
  end  
end
