class AddColumnsToGirls < ActiveRecord::Migration[5.1]
  def change
    add_column :girls, :description_path, :string
    add_column :girls, :thumbnail_image_id, :integer
  end
end
