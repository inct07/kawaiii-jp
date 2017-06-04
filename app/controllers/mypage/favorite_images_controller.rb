class Mypage::FavoriteImagesController < ApplicationController
  def index
    all_favorite_images = current_user.favorite_images.includes(:favorited_users, :girl)
    render 'mypage/favorite_images/no_favorite_images' if all_favorite_images.blank?
    @all_girls = all_favorite_images.map(&:girl).uniq
    @favorite_images = all_favorite_images.page(params[:page]).per(PAGE_LIMIT)
  end

  def show
    @girl_id = params[:id]
    all_favorite_images = current_user.favorite_images
    @all_girls = all_favorite_images.map(&:girl).uniq
    @favorite_images = all_favorite_images.where(girl_id: @girl_id).includes(:favorited_users, :girl)
    @favorite_images = @favorite_images.page(params[:page]).per(PAGE_LIMIT)
  end
end
