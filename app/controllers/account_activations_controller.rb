class AccountActivationsController < ApplicationController

	def edit
		user = User.find_by(email: params[:email])
		if user && !user.activated? && user.authenticated?(:activation, params[:id])
			user.activate
			flash[:success] = "Account activated. Now you can Log in."
			redirect_to(login_path)
		else
			flash[:danger] = "Invalid activation link"
			redirect_to(root_path)
		end
	end

end
