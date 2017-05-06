class GirlsController < ApplicationController
  def index
    @girls = Girl.all
  end

  def show
    @girl = Girl.find(params[:id])
    @images = Image.where(girl: @girl).includes(:favorited_users)
  end
end