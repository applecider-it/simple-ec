# 決済管理
class CheckoutServices::CheckoutService
  # 決済
  def checkout(user, summary)
    Rails.logger.debug "checkout"
    p user
    p summary

    User.transaction do
      user_order = UserOrder.new

      user.user_orders << user_order

      summary[:details].each do |detail|
        user_order_detail = UserOrderDetail.new(
          product: detail[:product],
          amount: detail[:amount],
          price: detail[:product].price,
        )

        user_order.user_order_details << user_order_detail
      end
    end

  end
end
