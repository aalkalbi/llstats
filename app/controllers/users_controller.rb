class UsersController < ApplicationController
before_action :check_authorization!,:except => [:new,:create]
#A - Page to create a new user.We use user new page for login.
def new
  @user = User.new
end

def index
  @user = User.new
  render "new"
end

#A - Create a user after user registration.
def create
  #if user checks the "Are you a coach" checkbox then we treat it as coach and save it as coach.Here "Single table Inheritence" comes in picture.
  if user_params[:is_a_coach].to_s == "1" #create a coach
    @user = User.new(user_params)
    @user.type = "Coach"
  else
    @user = User.new(user_params) #create a parent
    @user.type = "Parent"
  end
  if @user.save
    UserMailer.registration_notify(@user).deliver
    redirect_to root_url, :notice => "Signed up!.You will get an email."
  else
    render "new"
  end
end

#A - Show details of a registered user. 
def show
  @user = User.find_by_auth_token(cookies[:auth_token]) unless cookies[:auth_token].nil?
end

private

#A - Only allow mentioned parameters to come to the controller otherwise raise a exception and not save not allowed parameters. 
def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation,:dob,:first_name,:last_name,:postal_code,:is_a_coach,:type,:yrs_coached,:affiliation,:auth_token)
end

end
