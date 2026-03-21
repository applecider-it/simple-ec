# カート追加フォーム
class AddCartForm
  include ActiveModel::Model

  attr_accessor :amount

  validates :amount, numericality: { greater_than_or_equal_to: 1 }
end
