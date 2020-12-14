class AddAccountToOrders < ActiveRecord::Migration[6.0]
  def change
    add_reference :orders, :account, index: true, foreign_key: true
  end
end
