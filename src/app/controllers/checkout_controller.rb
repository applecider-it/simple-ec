# 購入管理コントローラー
class CheckoutController < ApplicationController
  before_action :authenticate_user!
  before_action :setup

  # 確認
  def confirm
    @user_order = UserOrder.new
  end

  # 購入
  def store
    checkout_service = CheckoutServices::CheckoutService.new

    @user_order = checkout_service.checkout(current_user, @summary, user_order_params)

    unless @user_order
      # エラーがないとき
      
      #@cart_service.clear

      redirect_to root_path, notice: "購入しました"
    else
      # エラーがあるとき

      render :confirm
    end
  end

  # 共通のセットアップ
  private def setup
    @cart_service = CartServices::CartService.new(session)
    @summary = @cart_service.summary
    @user_addresses = current_user.user_addresses.for_user
  end

  private def user_order_params
    params.expect(user_order: [ :user_address_id, :payment_method ])
  end
end
