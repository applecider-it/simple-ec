# 決済管理
class CheckoutServices::CheckoutService
  # 決済
  def checkout(user, summary, user_order_params)
    Rails.logger.debug "checkout"
    p user
    p summary
    p user_order_params

    user_order = user.user_orders.build

    user_order.user_address_id = user_order_params[:user_address_id]
    user_order.payment_method = user_order_params[:payment_method]

    summary[:details].each do |detail|
      user_order.user_order_details.build(
        product: detail[:product],
            amount: detail[:amount],
            price: detail[:product].price,
      )
    end

    if user_order.valid?
      # エラーがないとき
      User.transaction do
        user_order.save!
      end

      return nil
    else
      # エラーがあるとき

      return user_order
    end

  end
end
