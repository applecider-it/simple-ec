# ユーザーオーダーモデル
# 
# ドキュメント
# /documents/models/user_order.md
class UserOrder < ApplicationRecord
  include Discard::Model

  belongs_to :user

  has_many :user_order_details
end
