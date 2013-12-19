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
    @trend.destroy
    redirect_to :back
  end

  def index
    Trend.all
  end

  private

    def trend_params
      params.require(:trend).permit(:title)
    end
end
