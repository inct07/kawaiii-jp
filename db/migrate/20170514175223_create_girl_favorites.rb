class CreateGirlFavorites < ActiveRecord::Migration[5.1]
  def change
    create_table :girl_favorites do |t|
      t.references :girl, null: false
      t.references :user, null: false
      t.integer :rank, null: false, limit: 1
      t.timestamps null: false
    end

    add_foreign_key :girl_favorites, :girls
    add_foreign_key :girl_favorites, :users
  end
end
