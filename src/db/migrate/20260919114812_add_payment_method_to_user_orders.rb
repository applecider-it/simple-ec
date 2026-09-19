class AddPaymentMethodToUserOrders < ActiveRecord::Migration[8.0]
  def change
    add_column :user_orders, :payment_method, :integer, default: 0, null: false
  end
end
