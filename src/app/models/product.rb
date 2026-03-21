# 商品モデル
# 
# ドキュメント
# /documents/models/product.md
class Product < ApplicationRecord
  include Discard::Model

  has_one_attached :image

  has_many :user_order_details

  validates :name, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  validate :image_format

  # キーワード検索用スコープ
  scope :search_by_keyword, ->(keyword) {
    return all if keyword.blank?
    where("name LIKE ? OR description LIKE ?", "%#{sanitize_sql_like(keyword)}%", "%#{sanitize_sql_like(keyword)}%")
  }

  # イメージタグ用の値を返す
  def image_for_image_tag
    image.attached? ? image : "sample.svg"
  end

  # 画像フォーマット検査
  def image_format
    return unless image.attached?

    unless DataServices::ValidationService.valid_image(image)
      errors.add(:image, I18n.t('app.errors.messages.image'))
    end
  end
end
