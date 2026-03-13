class CartController < ApplicationController
  before_action :set_product, only: %i[ destroy ]
  before_action :setup_cart

  # 一覧画面
  def index
    @cart = @cart_service.all
  end

  # カートから削除
  def destroy
    redirect_to product_path(@product), notice: "カートから削除しました"
  end

  # カレントデータの取得
  private def set_product
    edit_service = ProductServices::EditService.new
    @product = edit_service.find_product(params.expect(:id))
  end

  # カートの設定
  private def setup_cart
    @cart_service = CartServices::CartService.new(session)
  end
end
