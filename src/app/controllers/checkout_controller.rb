# 購入管理コントローラー
class CheckoutController < ApplicationController
  before_action :authenticate_user!
  before_action :setup

  # 確認
  def confirm
    @user_addresses = current_user.user_addresses.for_user
  end

  # 購入
  def store
    checkout_service = CheckoutServices::CheckoutService.new

    user_address_id = params["user_address_id"]
    user_address = UserAddress.find(user_address_id)

    payment_method = params["payment_method"]

    checkout_service.checkout(current_user, @summary, user_address, payment_method)

    #@cart_service.clear

    redirect_to root_path, notice: "購入しました"
  end

  # 共通のセットアップ
  private def setup
    @cart_service = CartServices::CartService.new(session)
    @summary = @cart_service.summary
  end
end
