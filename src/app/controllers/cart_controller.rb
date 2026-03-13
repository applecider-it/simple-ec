class CartController < ApplicationController
  before_action :set_product, only: %i[ destroy ]
  before_action :setup

  # 一覧画面
  def index
    @summary = @cart_service.summary
  end

  # カートから削除
  def destroy
    @cart_service.destroy(@product)
    redirect_to cart_path, notice: "カートから削除しました"
  end

  # カレントデータの取得
  private def set_product
    edit_service = ProductServices::EditService.new
    info = edit_service.find_product(params.expect(:id))
    @product = info[:product]
  end

  # 共通のセットアップ
  private def setup
    @cart_service = CartServices::CartService.new(session)
  end
end
