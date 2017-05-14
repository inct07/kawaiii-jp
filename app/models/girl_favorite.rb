class GirlFavorite < ApplicationRecord
  class OverMaxError < StandardError; end

  FAVORITE_GIRL_MAX = 7
  before_create :check_favorite_girl_num

  belongs_to :user
  belongs_to :girl

  private

  def check_favorite_girl_num
    raise OverMaxError, '神7は7人までしか登録できません' if user.favorite_girls_num >= FAVORITE_GIRL_MAX
  end
end