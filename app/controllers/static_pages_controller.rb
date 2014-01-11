class StaticPagesController < ApplicationController
  def index
    @user = User.find_by(params[:id])
    if @user
    	@trend = @user.trends.build
    end
    @trends = Trend.all
  end
end
