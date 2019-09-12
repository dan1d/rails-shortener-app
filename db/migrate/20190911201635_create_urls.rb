class CreateUrls < ActiveRecord::Migration[5.2]
  def change
    create_table :urls do |t|
      t.string :short_url, index: true, null: false, unique: true
      t.string :long_url, null: false, unique: true
      t.string :title
      t.integer :views, index: true, default: 0

      t.timestamps
    end
  end
end
