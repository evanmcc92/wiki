class StaticPagesController < ApplicationController
  def index
    @user = User.find_by(params[:id])
    @trend = @user.trends.build
    @trends = @user.trends
  end
end
