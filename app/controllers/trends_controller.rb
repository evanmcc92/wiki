class TrendsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]

  def create
    @trend = current_user.trends.build(trend_params)
    if @trend.save
      flash[:success] = "Trend created!"
      redirect_to :back
    else
      render :back
    end
  end

  def destroy
    @trend = Trend.find(params[:id])
    @trend.destroy
    redirect_to root_url
  end

  def index    
    @user = User.find_by(params[:id])
    if @user
      @trend = @user.trends.build
    end
    @trends = Trend.all
  end

  private

    def trend_params
      params.require(:trend).permit(:title)
    end
end
