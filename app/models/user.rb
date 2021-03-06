class User < ApplicationRecord
  enum authority: {
    user:  0,
    admin: 1
  }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :image_favorites, dependent: :destroy
  has_many :favorite_images, through: :image_favorites, source: 'image'
  has_many :girl_favorites, dependent: :destroy
  has_many :favorite_girls, through: :girl_favorites, source: 'girl'

  def favorite_girls_num
    favorite_girls.count
  end

  def image_favorites_num_per_girl(girl_id)
    favorite_images.select { |image| image.girl_id == girl_id }.count
  end
end
