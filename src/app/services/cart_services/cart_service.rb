# カート管理
class CartServices::CartService
  def initialize(session)
    @data_service = DataService.new(session)
    @session = session
    @session_key = :cart
  end

  # 商品追加
  def add(product, add_cart_form)
    Rails.logger.debug "product id #{product.id} add_cart_form.amount #{add_cart_form.amount}"

    cart = @data_service.get_session

    @data_service.add_cart_product(cart, product, add_cart_form)

    @data_service.set_session(cart)

    Rails.logger.debug "SESSION :cart"
    p @session[@session_key]
  end

  # 商品サマリー
  def summary
    list = @data_service.cart_list

    summary_service = OrderServices::SummaryService.new

    summary = summary_service.summary_by_cart(list)

    Rails.logger.debug "summary"
    p summary

    summary
  end

  # 商品削除
  def destroy(product)

    cart = @data_service.get_session

    @data_service.delete_cart_product(cart, product)

    @data_service.set_session(cart)

    Rails.logger.debug "SESSION :cart"
    p @session[@session_key]
  end

  # クリア
  def clear
    @data_service.clear
  end

  # カウント
  def count
    @data_service.count
  end
end
