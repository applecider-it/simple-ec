# ユーザーオーダーモデル
# 
# ドキュメント
# /documents/models/user_order.md
class UserOrder < ApplicationRecord
  include Discard::Model

  belongs_to :user
  belongs_to :user_address, optional: true

  has_many :user_order_details

  enum :order_status, {
    pending: 0,
    paid: 1,
    shipped: 2,
    cancelled: 3
  }

  enum :payment_method, {
    credit_card: 0, # クレジットカード
    bank_transfer: 1, # 銀行振込
    convenience_store: 2, # コンビニ払い
    cod: 3 # 代金引換
  }

  validates :payment_method, presence: { message: "%{attribute}を選択してください" }
  validates :payment_method, inclusion: {
    in: ->(record) { record.class.active_payment_methods },
    message: "選択できない支払方法です"
  }
  validates :user_address, presence: { message: "%{attribute}を選択してください" }
  validate :user_address_belongs_to_user


  # 有効なオーダーステータス
  def self.active_order_statuses
    %W[pending paid shipped cancelled]
  end

  # 有効なオーダーステータスのキー文字列と表示名のハッシュ
  def self.active_order_statuses_hash
    order_statuses_i18n.slice(*active_order_statuses)
  end

  # 有効な支払方法
  def self.active_payment_methods
    %W[bank_transfer convenience_store cod]
  end

  # 有効な支払方法のキー文字列と表示名のハッシュ
  def self.active_payment_methods_hash
    payment_methods_i18n.slice(*active_payment_methods)
  end

  # user_address が自分自身(user)の住所であることを検証する
  private def user_address_belongs_to_user
    return if user_address.nil? || user.nil?

    if user_address.user_id != user_id
      errors.add(:user_address_id, "この住所は選択できません")
    end
  end
end
