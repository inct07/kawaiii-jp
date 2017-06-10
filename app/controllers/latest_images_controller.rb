class LatestImagesController < ApplicationController
  def index
    page = params[:page] || 1
    start = (page.to_i - 1) * PAGE_LIMIT
    @latest_images = LatestImages.read(start, PAGE_LIMIT)
    @current_user_favorite_images = current_user.favorite_images
  end
end