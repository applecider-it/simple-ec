# オーダー管理コントローラー
class Admin::OrdersController < Admin::BaseController
  before_action :set_user_order, only: %i[ edit update destroy restore ]
  before_action :edit_common, only: %i[ edit update ]

  # 一覧画面
  def index
    list_service = AdminServices::OrderServices::ListService.new

    page = params[:page]
    @user_id = params[:user_id]

    @summary_service = OrderServices::SummaryService.new

    @user_orders = list_service.get_list(page, @user_id)
  end

  # 新規作成画面
  def new
    @user_order = UserOrder.new
  end

  # 更新画面
  def edit
  end

  # 新規作成処理
  def create
    @user_order = UserOrder.new(user_order_params)

    if @user_order.valid?
      # エラーがないとき

      @user_order.save

      redirect_to edit_admin_user_order_path(@user_order), notice: "作成しました。"
    else
      # エラーがあるとき
      
      render :new, status: :unprocessable_entity
    end
  end

  # 更新処理
  def update
    @user_order.assign_attributes(user_order_params)

    if @user_order.valid?
      # エラーがないとき

      @user_order.save

      redirect_to edit_admin_user_order_path(@user_order), notice: "更新しました。", status: :see_other
    else
      # エラーがあるとき
      
      render :edit, status: :unprocessable_entity
    end
  end

  # 削除処理
  def destroy
    @user_order.discard

    redirect_to edit_admin_user_order_path(@user_order), notice: "削除しました。", status: :see_other
  end

  # 復元処理
  def restore
    @user_order.undiscard

    redirect_to edit_admin_user_order_path(@user_order), notice: "復元しました。", status: :see_other
  end


  # カレントデータの取得
  private def set_user_order
    @user_order = UserOrder.find(params.expect(:id))
  end

  # 変更可能な項目だけを絞り込む
  private def user_order_params
    params.expect(user_order: [ :user_id ])
  end

  # 更新画面の共通処理
  private def edit_common
  end
end
