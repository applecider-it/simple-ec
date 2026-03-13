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

    Rails.logger.debug "SESSION :cart"
    p @session[@session_key]
  end

  # 商品サマリー
  def summary
    list = cart_list

    checkout_service = CheckoutServices::CheckoutService.new

    summary = checkout_service.summary(list)

    Rails.logger.debug "summary"
    p summary

    summary
  end

  # 商品削除
  def destroy(product)

    cart = get_session

    init_cart_product(cart, product)
    delete_cart_product(cart, product)

    set_session(cart)

    Rails.logger.debug "SESSION :cart"
    p @session[@session_key]
  end

  # カート情報
  private def cart_list
    cart = get_session

    product_ids = cart.keys

    # index_by(&:id) で { 1 => product_obj, 3 => product_obj } の形にする
    products = Product.where(id: product_ids).index_by(&:id)

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
