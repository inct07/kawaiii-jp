class LatestImagesController < ApplicationController
  def index
    @latest_images = LatestImage.all
    @current_user_favorite_images = current_user.favorite_images
  end
end