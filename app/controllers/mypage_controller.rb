class MypageController < ApplicationController
  def favorites
    @girl_id = params[:girl_id]
    @images = current_user.favorite_images.includes(:favorited_users)
    get_favorite_count
  end

  private
  def get_favorite_count
    @favo_count = {}
    @images.each do |image|
      if @favo_count[image.girl_id].blank?
        @favo_count.store(image.girl_id, 0)
      end
      @favo_count.store(image.girl_id, @favo_count[image.girl_id] + 1)
    end
  end
end
