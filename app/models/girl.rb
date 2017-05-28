class Girl < ApplicationRecord
  has_many :images, dependent: :destroy, foreign_key: 'girl_id'
  has_one :thumbnail_image, class_name: 'Image', primary_key: 'thumbnail_image_id', foreign_key: 'id'
  has_many :girl_favorites, dependent: :destroy
  has_many :favorited_users, through: :girl_favorites, source: 'user'

  HUMAN_NAME_REGEXP = /\A[\p{han}\p{hiragana}\p{katakana}\u{30fc}\p{alpha}]+\z/
  URI_RAGEXP = /\A#{URI::regexp(%w(http https))}\z/

  validates :name, presence: true, format: { with: HUMAN_NAME_REGEXP, allow_blank: true }
  validates :description_path, format: {with: URI_RAGEXP, allow_blank: true}
end