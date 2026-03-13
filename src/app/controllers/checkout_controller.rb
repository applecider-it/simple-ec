class CheckoutController < ApplicationController
  before_action :authenticate_user!
  before_action :setup

  # 確認
  def confirm
  end

  # 購入
  def store
    checkout_service = CheckoutServices::CheckoutService.new

    checkout_service.checkout(current_user, @summary)

    redirect_to root_path, notice: "購入しました"
  end

  # 共通のセットアップ
  private def setup
    cart_service = CartServices::CartService.new(session)
    @summary = cart_service.summary
  end
end
