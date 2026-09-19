# ユーザー住所モデル
# 
# ドキュメント
# /documents/models/user_address.md
class UserAddress < ApplicationRecord
  include Discard::Model

  belongs_to :user

  validates :postal_code, :prefecture, :city, :address_line1, presence: true

  scope :for_user, ->() { kept.order(id: :desc) }

  def prefecture_text
    prefectures = I18n.t('app.data.prefectures')
    prefectures[prefecture]
  end
end
