class PasswordResetsController < ApplicationController
	before_action :get_user,         only: [:edit, :update]
	before_action :validate_user, only: [:edit, :update]
	before_action :check_expiration, only: [:edit, :update]
  def new
  end

  def update
  	if params[:user][:password].empty?
  		@user.errors.add(:password, "can't be empty")
  		render 'edit'
  	elsif @user.update_attributes(user_params)
  		@user.update_attribute(:reset_digest, nil)
  		flash[:success] = "Password has been reset."
  		redirect_to (login_path)
  	else
  		render 'edit'
  	end
  end

  def create

  	#debugger
  	@user = User.find_by(email: params[:password_reset][:email])
  	if @user
  		@user.create_reset_digest
  		@user.send_password_reset_email
  		flash[:info] = "Email sent with password reset instructions."
  		redirect_to(root_url)
  	else
  		flash.now[:danger] = "Email address nout found."
  		render 'new'
  	end
  end

  def edit
  end

  private 

  	  def user_params
  	  	params.require(:user).permit(:password, :password_confirmation)
  	  end

	  def check_expiration
	  	if @user.password_reset_expired?
	  		flash[:danger] = "Password reset has expired."
	  		render 'new'
	  	end
	  end

	  def get_user
      	@user = User.find_by(email: params[:email])
  	  end

	  def validate_user
	  	unless (@user && @user.activated? && @user.authenticated?(:reset, params[:id]))
	  		redirect_to(root_url)
	  	end

	  end

end
