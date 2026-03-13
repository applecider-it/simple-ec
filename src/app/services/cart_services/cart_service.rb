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
class CartServices::CartService
  def initialize(session)
    @session = session
    @session_key = :cart
  end

  # 商品追加
  def add(product, add_cart_form)
    Rails.logger.debug "product id #{product.id} add_cart_form.amount #{add_cart_form.amount}"

    #@session.delete(@session_key)  # 動作確認用

    cart = get_session

    init_cart_product(cart, product)
    add_cart_product(cart, product, add_cart_form)

    set_session(cart)

    p @session[@session_key]
  end

  # 商品一覧
  def all
    list = []

    cart = get_session

    cart.each do |product_id, row|
      list.push({
        amount: row["amount"],
        product: Product.find(product_id),
      })
    end

    {
      list: list,
    }
  end

  # 一時データに、商品追加
  private def add_cart_product(cart, product, add_cart_form)
    cart[product.id.to_s]["amount"] += add_cart_form.amount.to_i
  end

  # 一時データの、商品初期化
  private def init_cart_product(cart, product)
    initial_data = {
      "amount" => 0,
    }
    cart[product.id.to_s] = cart[product.id.to_s] || initial_data
  end

  # 一時データの、商品削除
  private def delete_cart_product(cart, product)
    cart.delete(product.id.to_s)
  end

  # セッションから取得
  private def get_session
    @session[@session_key] || {}
  end

  # セッションに設定
  private def set_session(cart)
    @session[@session_key] = cart
  end
end
