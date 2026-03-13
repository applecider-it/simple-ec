# マイページ  オーダー管理
class OrdersController < ApplicationController
  before_action :authenticate_user!

  # 一覧画面
  def index
    list_service = OrderServices::ListService.new

    page = params[:page]

    @summary_service = OrderServices::SummaryService.new

    @user_orders = list_service.get_list(current_user, page)
  end
end
