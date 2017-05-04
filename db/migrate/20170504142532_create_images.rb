class CreateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :images do |t|
      t.references :girl, null: false
      t.string :img_path, null: false
      t.timestamps null: false
    end

    add_foreign_key :images, :girls
  end
end
