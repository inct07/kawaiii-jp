class Image < ApplicationRecord
  belongs_to :girl
  has_many :image_favorites, dependent: :destroy
  has_many :favorited_users, through: :image_favorites, source: 'user'
end