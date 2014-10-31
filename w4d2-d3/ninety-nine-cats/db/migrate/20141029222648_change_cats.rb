class ChangeCats < ActiveRecord::Migration
  def change
    add_column :cats, :user_id, :integer
    change_column :cats, :user_id, :integer, null: false
    add_index :cats, :user_id
    add_index :cats, [:id, :user_id], unique: true
  end
end
