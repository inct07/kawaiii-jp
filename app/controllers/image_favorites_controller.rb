class ImageFavoritesController < ApplicationController
  def create
    ImageFavorite.create(user: current_user, image_id: params[:image_id])
  end

  def destroy
    image_favorite = ImageFavorite.find_by(user: current_user, image_id: params[:image_id])
    image_favorite.destroy
  end
end