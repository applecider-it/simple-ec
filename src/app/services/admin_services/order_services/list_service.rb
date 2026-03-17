# オーダー管理一覧関連管理
class AdminServices::OrderServices::ListService
  # 一覧取得
  def get_list(user, page)
    user
      .user_orders
      .includes(user_order_details: :product)
      .order(id: :desc)
      .page(page)
      .per(5)
  end
end
