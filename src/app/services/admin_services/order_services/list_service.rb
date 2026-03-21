# オーダー管理一覧関連管理
class AdminServices::OrderServices::ListService
  # 一覧取得
  def get_list(page, user_id)
    user_orders = UserOrder
      .includes([
        :user,
        { user_order_details: :product }
      ])
      .order(id: :desc)
    
    if user_id.present?
      user_orders = user_orders.where(user_id: user_id)
    end
    
    user_orders
      .page(page)
      .per(5)
  end
end
