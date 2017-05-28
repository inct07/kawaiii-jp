class Mypage::FavoriteImagesController < ApplicationController
  def index
    @images = current_user.favorite_images.includes(:favorited_users, :girl)
    @all_girls = @images.map(&:girl).uniq
    render 'mypage/favorite_images/no_favorite_images' if @images.blank?
  end

  def show
    @girl_id = params[:id]
    all_favorite_images = current_user.favorite_images.includes(:favorited_users, :girl)
    @images = all_favorite_images.select { |image| image.girl_id == @girl_id.to_i }
    @all_girls = all_favorite_images.map(&:girl).uniq
  end
end
