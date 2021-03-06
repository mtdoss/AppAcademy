class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.string :url
      t.text :content
      t.integer :author_id, null: false
      t.integer :sub_id, null: false

      t.timestamps
    end
  end
end
