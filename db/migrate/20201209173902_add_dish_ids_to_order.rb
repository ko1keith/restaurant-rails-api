class AddDishIdsToOrder < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :dish_ids, :integer, array: true, default:[]
    add_column :orders, :price, :decimal 
    add_column :dishes, :price, :decimal

  end
end
