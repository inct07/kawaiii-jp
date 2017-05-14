class Mypage::FavoriteImagesController < ApplicationController
  def index
    @images = current_user.favorite_images.includes(:favorited_users)
    render 'mypage/favorite_images/no_favorite_images' if @images.blank?
  end

  def show
    @girl_id = params[:girl_id]
  end
end
