class CreateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :images do |t|
      t.string :img_path, null: false
      t.string :girl_name, null: false

      t.timestamps null: false
    end

    add_index :images, :girl_name
  end
end
