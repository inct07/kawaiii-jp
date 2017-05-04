class FavoritesController < ApplicationController
  def create
    Favorite.create(user: current_user, image_id: params[:image_id])
  end

  def destroy
    favorite = Favorite.find_by(user: current_user, image_id: params[:image_id])
    favorite.destroy
  end
end