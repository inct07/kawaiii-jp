class Girl < ApplicationRecord
  has_many :images, dependent: :destroy, foreign_key: 'girl_id'
end