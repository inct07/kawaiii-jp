class ChangeDatatypeImgPathOfImages < ActiveRecord::Migration[5.1]
  def change
    change_column :images, :img_path, :text
  end
end
