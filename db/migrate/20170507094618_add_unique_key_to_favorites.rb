class AddUniqueKeyToFavorites < ActiveRecord::Migration[5.1]
  def change
    add_index :favorites, [:user_id, :image_id], unique: true
  end
end
