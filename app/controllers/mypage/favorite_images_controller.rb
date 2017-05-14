class Mypage::FavoriteImagesController < ApplicationController
  def index
    @images = current_user.favorite_images.includes(:favorited_users)
  end

  def show
    @girl_id = params[:girl_id]
  end
end
