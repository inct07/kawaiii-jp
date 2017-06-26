class GirlsController < ApplicationController
  def index
    @girls = Girl.all
  end

  def show
    @girl = Girl.find(params[:id])
    @images = Image.where(girl: @girl).page(params[:page]).per(PAGE_LIMIT)
    @current_user_favorite_images = current_user.favorite_images.where(girl: @girl) if user_signed_in?
  end
end
