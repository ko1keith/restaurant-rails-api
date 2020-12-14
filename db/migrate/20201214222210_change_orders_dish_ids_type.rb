class ChangeOrdersDishIdsType < ActiveRecord::Migration[6.0]
  def change
    change_column :orders, :dish_ids, :text
  end
end
