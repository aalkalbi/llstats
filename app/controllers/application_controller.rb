class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

#A - Security check to check secure token to prevent Cross site request forgery.
  protect_from_forgery with: :exception
#A - Current User will maintain current user session after user login.
  helper_method :current_user

#A - Check unauthorized access of user and if user not login but try to access url.Always redirect user to login page.
  def check_authorization!
    if !current_user
      redirect_to root_url, :notice => "Unauthorized Access."
      return false
    end
  end
  #A - This method protect from Unauthorized access of PARENT on only Coach pages (like league and team). If parent try to unautorized access then this method logout him and send back to login page.
  def check_if_coach!
    if current_user.type.to_s != "Coach"
      redirect_to log_out_path, :notice => "Unauthorized Access.Hence Log out."
      return false
    end
  end

	private
#A - set current user.
	def current_user
	  @current_user ||= User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
	end

end
