class SessionsController < ApplicationController
#A - Page to create a new user session.Currently we are not using this as we use user new page for login.
def new
  session[:user_id] = nil
end

#A - Create a user session after user login.
def create
  user = User.authenticate(params[:email], params[:password])
  if user
    cookies[:auth_token] = user.auth_token
    if user.type.to_s == "Coach"
      redirect_to coach_path(user.auth_token)
    else
      redirect_to parent_path(user.auth_token)
    end
  else
    flash.now.alert = "Invalid email or password"
    render "new"
  end
end
#A - Destroy a user session.
def destroy
  cookies.delete(:auth_token)
  redirect_to root_url, :notice => "Logged out!"
end

end
