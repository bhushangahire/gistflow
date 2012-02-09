class CreateFollowers < ActiveRecord::Migration
  def change
    create_table :followers do |t|
      t.integer :user_id
      t.integer :tag_id
    end
    add_index :followers, [:user_id, :tag_id], :unique => true
  end
end
