class RenameFavoritesToImageFavorites < ActiveRecord::Migration[5.1]
  def change
    rename_table :favorites, :image_favorites
  end
end
