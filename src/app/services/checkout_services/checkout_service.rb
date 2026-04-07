# 決済管理
class CheckoutServices::CheckoutService
  # 決済
  def checkout(user, summary)
    Rails.logger.debug "checkout"
    p user
    p summary

    User.transaction do
      user_order = user.user_orders.build

      summary[:details].each do |detail|
        user_order.user_order_details.build(
          product: detail[:product],
              amount: detail[:amount],
              price: detail[:product].price,
        )
      end

      user_order.save!
    end

  end
end
