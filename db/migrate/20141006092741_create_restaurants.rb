class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.text :description
      t.string :slug

      t.timestamps
    end
  end
end
