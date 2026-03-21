# ユーザーオーダー詳細モデル
# 
# ドキュメント
# /documents/models/user_order_detail.md
class UserOrderDetail < ApplicationRecord
  belongs_to :user_order
  belongs_to :product
end
