class SessionsController < ApplicationController
#A - Page to create a new user session.Currently we are not using this as we use user new page for login.
def new
end

#A - Create a user session after user login.
def create
  user = User.authenticate(params[:email], params[:password])
  if user
    session[:user_id] = user.id
    if user.type.to_s == "Coach"
      redirect_to coach_path(user.id)
    else
      redirect_to parent_path(user.id)
    end
  else
    flash.now.alert = "Invalid email or password"
    render "new"
  end
end
#A - Destroy a user session.
def destroy
  session[:user_id] = nil
  redirect_to root_url, :notice => "Logged out!"
end

end
