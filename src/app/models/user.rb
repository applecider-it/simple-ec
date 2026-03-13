# ユーザーモデル
# 
# ドキュメント
# /documents/models/user.md
class User < ApplicationRecord
  include Discard::Model

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_discard :discard_all_relations

  has_many :user_orders

  # キーワード検索用スコープ
  scope :search_by_keyword, ->(keyword) {
    return all if keyword.blank?
    where("email LIKE ?", "%#{sanitize_sql_like(keyword)}%")
  }

  # ログイン可能かチェック
  # 
  # Devise が内部で使ってるメソッド
  def active_for_authentication?
    super && !discarded?
  end

  # アカウントが無効な理由のメッセージに使われるキーを返す
  # 
  # 言語ファイルの、devise.failure.{returnvalue}を表示
  # 
  # Devise が内部で使ってるメソッド
  def inactive_message
    discarded? ? :deleted_account : super
  end

  # メーラーを設定
  # 
  # Devise が内部で使ってるメソッド
  def devise_mailer
    UserDeviseMailer
  end

  # 関連テーブル全てを高速に論理削除
  private def discard_all_relations
    #user_tweets.kept.update_all(discarded_at: Time.current)
  end

  # シリアライズ対象から除外
  def self.hidden_attributes
    [:created_at, :updated_at, :discarded_at]
  end
end
