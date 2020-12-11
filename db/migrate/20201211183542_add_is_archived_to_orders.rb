class AddIsArchivedToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :is_archived, :boolean, default: false
  end
end
