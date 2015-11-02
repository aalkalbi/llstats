class PasswordResetsController < ApplicationController
  
#A - When user click on "forgotten password". It opens new page for user where user puts its email. Create method send email wih reset instrucions.
def create
  user = User.find_by_email(params[:email])
  user.send_password_reset if user
  redirect_to root_url, :notice => "Email sent with password reset instructions."
end

#A - When user click link from reset instruction email. It will land on reset password edit page.
def edit
  @user = User.find_by_password_reset_token!(params[:id])
end

#A - When user enter password and confirm password on reset page. This method update user record with new password.
def update
  @user = User.find_by_password_reset_token!(params[:id])
  paramm = params.has_key?(:coach) ? coach_params : parent_params
  @user.attributes = paramm
  @user.is_pass_reset = true
  if @user.password_reset_sent_at < 2.hours.ago
    redirect_to new_password_reset_path, :alert => "Password reset has expired."
  elsif @user.save
    redirect_to root_url, :notice => "Password has been reset!"
  else
    render :edit
  end
end

private

#A - Allowed params
def coach_params
    params.require(:coach).permit(:username, :email, :password, :password_confirmation,:dob,:first_name,:last_name,:postal_code,:is_a_coach,:type,:yrs_coached,:affiliation,:password_reset_token)
end

def parent_params
    params.require(:parent).permit(:username, :email, :password, :password_confirmation,:dob,:first_name,:last_name,:postal_code,:is_a_coach,:type,:yrs_coached,:affiliation,:password_reset_token)
end

end
