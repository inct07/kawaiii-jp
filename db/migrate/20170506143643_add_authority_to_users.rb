class AddAuthorityToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :authority, :integer, null: false, default: 0
  end
end
