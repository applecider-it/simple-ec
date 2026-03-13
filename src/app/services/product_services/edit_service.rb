# 商品編集関連管理
class ProductServices::EditService
  # 有効な商品を取得
  def find_product(id)
    product = Product.kept.find(id)

    max_amount = 5

    amount_hash = (1..max_amount).map { |n| [n, "#{n}個"] }.to_h

    {
      product: product,
      amount_hash: amount_hash,
    }
  end
end
