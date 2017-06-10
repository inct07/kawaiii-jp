class Mypage::FavoriteImagesController < ApplicationController
  def index
    all_favorite_images = current_user.favorite_images.includes(:girl)
    render 'mypage/favorite_images/no_favorite_images' if all_favorite_images.blank?
    @all_girls = all_favorite_images.map(&:girl).uniq
    @favorite_images = all_favorite_images.page(params[:page]).per(PAGE_LIMIT)
    @current_user_favorite_images = current_user.favorite_images
  end

  def show
    @girl_id = params[:id]
    all_favorite_images = current_user.favorite_images
    @all_girls = all_favorite_images.map(&:girl).uniq
    @favorite_images = all_favorite_images.where(girl_id: @girl_id).includes(:girl)
    @favorite_images = @favorite_images.page(params[:page]).per(PAGE_LIMIT)
    @current_user_favorite_images = current_user.favorite_images.where(girl_id: @girl_id)
  end
end
