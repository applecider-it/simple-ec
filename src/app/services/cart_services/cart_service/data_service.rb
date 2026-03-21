# カート管理
# 
# カートセッション内容
# 
# クッキーセッションではJSONになるので、キーは文字列
# 
# {
#   "product.id": {
#     "amount": int
#   }
# }
# 
# 例: { "1" => { "amount" => 2 }, "3" => { "amount" => 1 } }
class CartServices::CartService::DataService
  def initialize(session)
    @session = session
    @session_key = :cart
  end

  # カート情報
  def cart_list
    cart = get_session

    product_ids = cart.keys

    # index_by(&:id) で { 1 => product_obj, 3 => product_obj } の形にする
    products = Product.includes([:image_attachment]).where(id: product_ids).index_by(&:id)

    list = []

    cart.each do |product_id, row|
      product = products[product_id.to_i]  # セッションキーが文字列のため to_i
      next unless product  # 商品が削除されている場合はスキップ

      list.push({
        amount: row["amount"].to_i,
        product: product
      })
    end

    list
  end

  # 一時データに、商品追加
  def add_cart_product(cart, product, add_cart_form)
    init_cart_product(cart, product)
    cart[product.id.to_s]["amount"] += add_cart_form.amount.to_i
  end

  # 一時データの、商品削除
  def delete_cart_product(cart, product)
    init_cart_product(cart, product)
    cart.delete(product.id.to_s)
  end

  # セッションから取得
  def get_session
    @session[@session_key] || {}
  end

  # セッションに設定
  def set_session(cart)
    @session[@session_key] = cart
  end

  # クリア
  def clear
    @session.delete(@session_key)
  end

  # カウント
  def count
    cnt = 0
    get_session.each do |idx, row|
      cnt += row["amount"]
    end
    cnt
  end

  # 一時データの、商品初期化
  private def init_cart_product(cart, product)
    initial_data = {
      "amount" => 0,
    }
    cart[product.id.to_s] = cart[product.id.to_s] || initial_data
  end
end
