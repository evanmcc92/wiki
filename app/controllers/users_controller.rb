class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to user
    else
      flash.now[:error] = 'Invalid email/password combination'
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
    if @user.update_attributes(update_user_params)
      redirect_to edit_user_path(@user), :flash => {:success => "You've Successful Updated Your Account!"}
    else
      render "edit"
    end
  end

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  private

    def user_params
      params.require(:user).permit(:username, :email, :password)
    end
end
