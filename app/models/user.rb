class User < ApplicationRecord
  enum authority: {
    user:  0,
    admin: 1
  }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :favorites
  has_many :favorite_images, through: :favorites, source: 'image'
end
