# オーダーの集計管理
class OrderServices::SummaryService
  # 計算
  def summary(list)
    details = []

    all_total = 0

    list.each do |row|
      product = row[:product]
      amount = row[:amount]
      total = product.price * amount

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
