class Mypage::FavoriteGirlsController < ApplicationController
  def index
    @favorite_girls = current_user.favorite_girls.order('rank')
  end

  def new
    @girl_favorite = GirlFavorite.new
  end

  def create
    rank = current_user.favorite_girls_num + 1
    @girl_favorite = GirlFavorite.new(girl_favorite_params.merge(rank: rank))
    begin
      @girl_favorite.save!
      flash.notice = '神7を追加しました'
      redirect_to mypage_favorite_girls_path
    rescue GirlFavorite::OverMaxError => e
      flash.alert = e.message
      redirect_to mypage_favorite_girls_path
    rescue => e
      flash.alert = e.message
      render action: 'new'
    end
  end

  private

  def girl_favorite_params
    params.require(:girl_favorite).permit(
      :girl_id
    ).merge(user: current_user)
  end
end