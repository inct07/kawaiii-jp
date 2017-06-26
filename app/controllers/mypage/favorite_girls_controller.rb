class Mypage::FavoriteGirlsController < ApplicationController
  before_action :authenticate_user!

  def index
    @girl_favorites = current_user.girl_favorites.order('rank').includes(girl: [:thumbnail_image])
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
    rescue GirlFavorite::DuplicateError, StandardError => e
      flash.alert = e.message
      render action: 'new'
    end
  end

  def edit
    @girl_favorite = GirlFavorite.find(params[:id])
  end

  def update
    @girl_favorite = GirlFavorite.find(params[:id])
    @girl_favorite.assign_attributes(girl_favorite_params)
    begin
      @girl_favorite.save!
      flash.notice = '神7を変更しました'
      redirect_to mypage_favorite_girls_path
    rescue GirlFavorite::DuplicateError, StandardError => e
      flash.alert = e.message
      render action: 'edit'
    end
  end

  private

  def girl_favorite_params
    params.require(:girl_favorite).permit(
      :girl_id
    ).merge(user: current_user)
  end
end