class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

#A - Security check to check secure token to prevent Cross site request forgery.
  protect_from_forgery with: :exception
#A - Current User will maintain current user session after user login.
  helper_method :current_user

	private

	def current_user
	  @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
	end
end
