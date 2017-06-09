class SessionsController < ApplicationController
  
  def new
  end

  def create
  	user = User.find_by_email(params[:session][:email].downcase)
  	if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or current_user
      else
        message = "Account not activated."
        message+= "Check your email address for the activation link."
        flash[:warning] = message
        redirect_to(root_path)  
      end		
  	else
  		flash.now[:danger] = 'Invalid email/password combination'
  		render 'new'
  	end	
  end

  def destroy
  	log_out if logged_in?
    redirect_to root_path
  end
end