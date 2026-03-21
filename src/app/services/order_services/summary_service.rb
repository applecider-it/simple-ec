# オーダーの集計管理
class OrderServices::SummaryService
  # カートから計算
  # 
  # list
  # 
  # [
  #   {
  #     product: Product
  #     amount: int
  #   }
  # ]
  def summary_by_cart(cart_list)
    list = []
    cart_list.each do |row|
      list.push({
        product: row[:product],
        amount: row[:amount],
        price: row[:product].price,
      })
    end

    summary(list)
  end

  # オーダーからサマリー取得
  def summary_by_user_order(user_order)
    list = []
    user_order.user_order_details.each do |user_order_detail|
      list.push({
        product: user_order_detail.product,
        amount: user_order_detail.amount,
        price: user_order_detail.price,
      })
    end

    summary(list)
  end

  # 計算
  # 
  # list
  # 
  # [
  #   {
  #     product: Product
  #     amount: int
  #     price: int
  #   }
  # ]
  # 
  # return
  # 
  # {
  #   detials: [
  #     {
  #       product: Product
  #       amount: int
  #       total: int
  #     }
  #   ]
  #   total: int
  # }
  private def summary(list)
    details = []

    all_total = 0

    list.each do |row|
      product = row[:product]
      amount = row[:amount]
      price = row[:price]
      total = price * amount

      all_total += total

      details.push(
        product: product,
        amount: amount,
        total: total,
      )
    end

    {
      details: details,
      total: all_total,
    }
  end
end
