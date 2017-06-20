class UsersController < ApplicationController
  before_action :logged_in_user,  only: [:edit, :update, :index, :destroy]
  before_action :correct_user,    only: [:edit, :update]
  before_action :admin_user,      only: :destroy

  def destroy
    User.find_by(id: params[:id]).destroy
    #DELETE FROM users WHERE users.id = ?, (params[:id]);
    flash[:success] = "User deleted"
    redirect_to(users_path)
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 10)
    @users = @users.sort_by{|user| user[:id]}
  end

	def show
		@user = User.find(params[:id])
    if (session[:user_id] != @user.id)
      flash.now[:danger] = "You can not switch to another account without log in."
      redirect_to user_path(User.find(session[:user_id]))
    end
	end

	def new
		@user = User.new
	end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to(login_path)
    else
      render 'edit' 
    end
      
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in to visit the page"
      redirect_to login_path
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end

	def create
    	@user = User.new(user_params)    # Not the final implementation!
    	if @user.save
           @user.send_activation_email
      		 flash[:info] = "Please check your email to activate your account!"
           redirect_to(root_path)
    	else
      	   render 'new'
    	end
  end

  private
    def user_params
      params.require(:user).permit(:email, :address, :password, :password_confirmation)
    end   
end