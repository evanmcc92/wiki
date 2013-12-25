class PagesController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]

  def create
  	@trend = Trend.find_by(params[:id])
    @page = @trend.pages.build(page_params)
    @page.user_id = current_user.id
    if @page.save
      flash[:success] = "Page created!"
      redirect_to @page
    else
      render 'index'
    end
    @user = User.find_by(params[:id])
    @trend = @user.trends.build
    @trends = Trend.all
  end

  def destroy
    @page = Page.find(params[:id])
    @page.destroy
    redirect_to root_url
  end

  def edit
    @page = Page.find(params[:id])
  end

  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(page_params)
      flash[:success] = "Profile updated"
      redirect_to @page
    else
      render 'edit'
    end
    @user = User.find_by(params[:id])
    @trend = @user.trends.build
   @trends = Trend.all
  end

  def new
    @page = Page.new


    @user = User.find_by(params[:id])
    @trend = @user.trends.build
    @trends = Trend.all
  end

  def show
    @user = User.find_by(params[:id])

    @page = Page.find_by(params[:id])

    @trends = Trend.all
    @trend = @user.trends.build
  end

  def index
  	@pages =Page.all
    @page = current_user.pages.build
    @user = User.find_by(params[:id])
    @trend = @user.trends.build
    @trends = Trend.all
  end

  private

    def page_params
      params.require(:page).permit(:title, :summary, :body, :trend_id, :user_id)
    end
end
