class GirlFavorite < ApplicationRecord
  class OverMaxError < StandardError; end
  class DuplicateError < StandardError; end

  FAVORITE_GIRL_MAX = 7
  before_save :check_favorite_girl_num
  before_save :check_favorite_girl_duplicate

  belongs_to :user
  belongs_to :girl

  private

  def check_favorite_girl_num
    raise OverMaxError, '神7は7人までしか登録できません' if user.favorite_girls_num >= FAVORITE_GIRL_MAX
  end

  def check_favorite_girl_duplicate
    raise DuplicateError, '同じ美少女は登録できません' if user.favorite_girls.any? {|girl| girl.id == self.girl_id }
  end
end