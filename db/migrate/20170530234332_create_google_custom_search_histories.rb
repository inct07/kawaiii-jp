class CreateGoogleCustomSearchHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :google_custom_search_histories do |t|
      t.unsigned_integer :request_by, null: false, limit: 1
      t.timestamps null: false
    end
  end
end
