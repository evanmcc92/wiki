class PagesController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]

  def create
    @page = current_user.pages.build(page_params)

    if @page.save
      flash[:success] = "Page created!"
      redirect_to @page
    else
      render 'index'
    end

    @trends = Trend.all
  end

  def destroy
    @page = Page.find(params[:id])

    if @page.destroy
      redirect_to root_url
      flash[:success] = "Page was successfully deleted"
    end
  end

  def edit
    @page = Page.find(params[:id])
  end

  def update
    @page = Page.find(params[:id])

    if @page.update_attributes(page_params)
      flash[:success] = "Page updated"
      redirect_to :back
    else
      render 'edit'
      flash[:error] = "Page was not updated"
    end

    if current_user
      @trend = current_user.trends.build
    end

    @trends = Trend.all
  end

  def new
    @page = Page.new


    @user = User.find_by(params[:id])
    @trend = @user.trends.build
    @trends = Trend.all
  end

  def show

    @page = Page.find(params[:id])

    @user = current_user

    if @user
      @trend = @user.trends.build
    end

    @trends = Trend.all
  end

  def index
  	@pages =Page.all
    @user = User.find_by(params[:id])
    if @user
      @trend = @user.trends.build
    end
    @trends = Trend.all


    if params[:search]
      @page = Page.search(params[:search])
    else
      @page = Page.all
    end
  end

  private

    def page_params
      params.require(:page).permit(:title, :summary, :body, :trend_id, :user_id)
    end
end
