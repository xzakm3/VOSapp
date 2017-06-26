class UsersController < ApplicationController
  U = 230
  Phases_price = 6.99
  include ScenariosHelper
  before_action :logged_in_user,  only: [:edit, :update, :index, :destroy]
  before_action :correct_user,    only: [:edit, :update]
  before_action :admin_user,      only: :destroy
  before_action :get_breakers_prices, only: :show
  before_action :get_my_scenarios, only: :show

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
           @user.activate
      		 flash[:info] = "Môžete sa prihlásiť."
           redirect_to(root_path)
    	else
      	   render 'new'
    	end
  end

  private
    def user_params
      params.require(:user).permit(:email, :address, :password, :password_confirmation)
    end

    def get_breakers_prices
      @array_of_ampers = [6, 10, 13, 16, 20, 25, 32, 40, 50, 63, 80]
      @amper_price_west = {}
      @amper_price_east = {}
      @array_of_ampers.each do |amper_value|
        @amper_price_west[amper_value] = amper_value * Phases_price
      end
      @amper_price_east[13] = 98.50
      @amper_price_east[16] = 121.00
      @amper_price_east[20] = 151.00
      @amper_price_east[25] = 189.00
      @amper_price_east[32] = 248.50
      @amper_price_east[40] = 310.50
      @amper_price_east[50] = 388.50
      @amper_price_east[63] = 489.00
      @amper_price_east[80] = 621.50
      @amper_price_east[100] = 981.00
      @amper_price_east[125] = 1635.00
      @amper_price_east[160] = 2093.00
      @amper_price_east[200] = 2616.50
      @amper_price_east[250] = 4089.00
      @amper_price_east[315] = 5152.00
      @amper_price_east[400] = 6542.50
    end
end