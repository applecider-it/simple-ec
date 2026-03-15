# ユーザーオーダー管理コントローラー
class Admin::UserOrdersController < Admin::BaseController
  before_action :setup

  # 一覧画面
  def index
    list_service = AdminServices::OrderServices::ListService.new

    page = params[:page]

    @summary_service = OrderServices::SummaryService.new

    @user_orders = list_service.get_list(@user, page)
  end

  # 共通のセットアップ
  private def setup
    @user = User::find(params.expect(:user_id))
  end
end
