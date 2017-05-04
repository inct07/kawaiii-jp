class MypageController < ApplicationController
  def favorites
    @images = current_user.favorite_images.includes(:favorited_users)
  end
end