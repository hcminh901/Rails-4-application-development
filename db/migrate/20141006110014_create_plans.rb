class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.integer :name
      t.integer :restaurants
      t.float :price
      t.integer :tables
      t.integer :menu_items
      t.integer :storage

      t.timestamps
    end
  end
end
