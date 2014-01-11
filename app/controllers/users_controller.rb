class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update]
  before_action :admin_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @trends = Trend.all
    @trend = @user.trends.build
  end

  def create
    @user = User.new(user_params)

    @user.admin = false

    if @user.save
      sign_in @user
      flash[:success] = "Welcome to Wiki!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_url
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def index
    @users = User.all
    @user = User.find_by(params[:id])
    if @user
      @trend = @user.trends.build
    end
    @trends = Trend.all
  end

  def new
    @user = User.new

    @users = User.find_by(params[:id])
    @trends = Trend.all
  end

  private

    def user_params
      params.require(:user).permit(:username, :email, :admin, :password)
    end

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
