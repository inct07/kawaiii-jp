class Image < ApplicationRecord
  belongs_to :girl
  has_many :favorites
  has_many :favorited_users, through: :favorites, source: 'user'
end