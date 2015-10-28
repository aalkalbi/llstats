class UsersController < ApplicationController
#A - Page to create a new user.We use user new page for login.
def new
  @user = User.new
end

#A - Create a user after user registration.
def create
  #if user checks the "Are you a coach" checkbox then we treat it as coach and save it as coach.Here "Single table Inheritence" comes in picture.
  if user_params[:is_a_coach].to_s == "1" #create a coach
    @user = Coach.new(user_params)
  else
    @user = Parent.new(user_params) #create a parent
  end
  if @user.save
    redirect_to root_url, :notice => "Signed up!"
  else
    render "new"
  end
end

#A - Show details of a registered user. 
def show
  @user = User.find(session[:user_id])
end

private

#A - Only allow mentioned parameters to come to the controller otherwise raise a exception and not save not allowed parameters. 
def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation,:dob,:first_name,:last_name,:postal_code,:is_a_coach,:type)
end

end
