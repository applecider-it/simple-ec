# オーダー一覧関連管理
class OrderServices::ListService
  # 一覧取得
  def get_list(user, page)
    user
      .user_orders
      .includes(user_order_details: :product)
      .order(id: :desc)
      .kept
      .page(page)
      .per(5)
  end
end
