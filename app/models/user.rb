class User < ApplicationRecord
  enum authority: {
    user:  0,
    admin: 1
  }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :image_favorites
  has_many :favorite_images, through: :image_favorites, source: 'image'
end
