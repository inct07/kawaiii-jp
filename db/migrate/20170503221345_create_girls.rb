class CreateGirls < ActiveRecord::Migration[5.1]
  def change
    create_table :girls do |t|
      t.string :name, null: false
      t.timestamps null: false
    end

    add_index :girls, :name
  end
end
