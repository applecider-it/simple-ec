# ユーザーオーダーモデル
# 
# ドキュメント
# /documents/models/user_order.md
class UserOrder < ApplicationRecord
  include Discard::Model

  belongs_to :user
  belongs_to :user_address

  has_many :user_order_details

  enum :order_status, { pending: 0, paid: 1, shipped: 2, cancelled: 3 }

  # 有効なオーダーステータスのキー文字列と表示名のハッシュ
  def self.active_order_statuses
    order_statuses_i18n.select { |key, _| %w[pending paid shipped cancelled].include?(key) }
  end
end
