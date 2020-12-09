class CreateDishes < ActiveRecord::Migration[6.0]
  def change
    create_table :dishes do |t|
      t.string "name", nullable: false
      t.integer "restaurant_id", nullable: false
      t.index ["restaurant_id"], name: "index_dishes_on_restaurant_id"
      t.timestamps
    end
  end
end
