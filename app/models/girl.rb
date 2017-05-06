class Girl < ApplicationRecord
  has_many :images, dependent: :destroy, foreign_key: 'girl_id'
  has_one :thumbnail_image, class_name: 'Image', primary_key: 'thumbnail_image_id', foreign_key: 'id'
end