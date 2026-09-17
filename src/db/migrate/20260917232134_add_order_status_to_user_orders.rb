class AddOrderStatusToUserOrders < ActiveRecord::Migration[8.0]
  def change
    add_column :user_orders, :order_status, :integer, default: 0, null: false
  end
end
