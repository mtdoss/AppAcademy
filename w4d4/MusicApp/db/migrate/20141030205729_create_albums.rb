class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.integer :band_id, null: false
      t.string :name, null: false
      t.boolean :live, default: false

      t.timestamps
    end
  end
end
