# ユーザーオーダーモデル
# 
# ドキュメント
# /documents/models/user_order.md
class UserOrder < ApplicationRecord
  include Discard::Model

  belongs_to :user
  belongs_to :user_address, optional: true

  has_many :user_order_details

  enum :order_status, { pending: 0, paid: 1, shipped: 2, cancelled: 3 }

  enum :payment_method, {
    credit_card: 0, # クレジットカード
    bank_transfer: 1, # 銀行振込
    convenience_store: 2, # コンビニ払い
    cod: 3 # 代金引換
  }

  validates :payment_method, presence: { message: "%{attribute}を選択してください" }
  validates :user_address, presence: { message: "%{attribute}を選択してください" }
  validate :user_address_belongs_to_user

  # 有効なオーダーステータスのキー文字列と表示名のハッシュ
  def self.active_order_statuses
    order_statuses_i18n.select { |key, _| %w[pending paid shipped cancelled].include?(key) }
  end

  # 有効な支払方法のキー文字列と表示名のハッシュ
  def self.active_payment_methods
    payment_methods_i18n.select { |key, _| %w[bank_transfer convenience_store cod].include?(key) }
  end

  # user_address が自分自身(user)の住所であることを検証する
  private def user_address_belongs_to_user
    return if user_address.nil? || user.nil?

    if user_address.user_id != user_id
      errors.add(:user_address_id, "この住所は選択できません")
    end
  end
end
