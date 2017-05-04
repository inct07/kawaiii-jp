class CreateFavorites < ActiveRecord::Migration[5.1]
  def change
    create_table :favorites do |t|
      t.references :image, null: false
      t.references :user, null: false
      t.timestamps null: false
    end

    add_foreign_key :favorites, :images
    add_foreign_key :favorites, :users
  end
end
